//+------------------------------------------------------------------+
//|                                           First_Trade_Method.mq4 |
//|                                                         itshosyn |
//|                                          http://www.itshosyn.com |
//+------------------------------------------------------------------+
#property copyright "itshosyn"
#property link      "http://www.itshosyn.com"
#property version   "1.00"
#property strict
#property show_inputs

//#include <lol.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   _ALERT();
   _CheckDay();
   _BAlance_Acc();
   _Trade_Method();
   _CheckPip();
   _getTakeProfit(ItIsALongPosition);
   _getStopLoss(ItIsALongPosition);
   _checkBars();
   _mavaLue();
   _rsiCheck();
   _volumeCheck();
   _macdCheck();
  }
//+------------------------------------------------------------------+





double pipValue;
input bool ItIsALongPosition = true;
input int Moving_Average_Period = 21; 
input int rsiPeriod = 14;
input ENUM_TIMEFRAMES Trade_TIMEFRAME = 60;
input ENUM_MA_METHOD Moving_Average_METHOD = 1;
input ENUM_APPLIED_PRICE PRICE_Declare = 5;
input int FastEMAmAcD = 12;
input int SlowEMAmAcD = 26;
input int SignalSMAmAcD = 9;



void _ALERT()
{
   Alert("");
   Alert("");
   Alert("");
}

double _BAlance_Acc()
{
      Alert("Account Balance is : ",AccountBalance());
      return AccountBalance();
}

double _getStopLoss(bool ItIsALongPositon)
{
   double StopLossPricee;
   
   if(ItIsALongPositon)
     {
       StopLossPricee = Ask - (pipValue * 30);
     }
   else
     {
       StopLossPricee = Bid + (pipValue * 30);
     }
     Alert("Stop Loss is :",StopLossPricee);
     return StopLossPricee;
}


double _getTakeProfit(bool ItIsALongPositon)
{
   double TakeProfitPricee;
   
   if(ItIsALongPositon)
     {
        TakeProfitPricee = Ask + (pipValue * 300);
     }
   else
     {
        TakeProfitPricee = Bid - (pipValue * 300);
     }
     Alert("Take Profit is :",TakeProfitPricee);
     return TakeProfitPricee;
}


void _CheckDay()
{
      int dayOfWeek = DayOfWeek();
      
      switch(dayOfWeek)
     {
      case 1 :Alert("It's Monday so let's make some MONEYYYYYYYYY");break;
      case 2 :Alert("It's Tuesday so let's make some MONEYYYYYYYYY");break;
      case 3 :Alert("It's Wednesday so let's make some MONEYYYYYYYYY");break;
      case 4 :Alert("It's Thursday so let's make some MONEYYYYYYYYY");break;
      case 5 :Alert("It's Friday So we don't open any positions just closing existing positions");break;
      case 6 :Alert("Market is Close idiot, Go Have fun");break;
      case 0 :Alert("Market is Close idiot, Go Have fun");break;
        
      default: Alert("The Day Does Not Exist !");break;   
 }
}


void _CheckPip() 
{
   
   if(_Digits == 5)
     {
      pipValue = 0.0001;
     }
   else if(_Digits == 3)
     {
      pipValue = 0.01;
     }
     Alert("Pip Value is : ",pipValue);
     
}


void _checkBars()
{
      for(int i=0;i<50;i++)
     {
      Print(Time[i], "  ",  Open[i], "  ",  High[i], "  ",  Low[i], "  ",  Close[i] );
     }
}


enum Enum_Trading_Methods
  {
   Very_Passive=1,
   Passive=2,
   Normal=3,
   Aggresive=4,
   Very_Aggresive=5
  };
  
  input Enum_Trading_Methods Trade_Method = 3;
  
  
void _Trade_Method ()
{
       switch(Trade_Method)
      {
       case 1 :Alert("Trading in Very Passive mode");break;
       case 2 :Alert("Trading in Passive mode");break;
       case 3 :Alert("Trading in Normal mode");break;
       case 4 :Alert("Trading in Aggresive mode");break;
       case 5 :Alert("Trading in Very Aggresive mode");break;
   
       default:Alert("No Other Method Exist");
         break;
      }
}


double _mavaLue(){


   double iMAvalue = iMA(NULL,Trade_TIMEFRAME,Moving_Average_Period,0,Moving_Average_METHOD,PRICE_Declare,0);
   Alert("Moving Average value is : ",NormalizeDouble(iMAvalue,Digits));
   
   return iMAvalue;

}

void _rsiCheck()
{
   double rsiCurrentValue = iRSI(NULL,Trade_TIMEFRAME,rsiPeriod,PRICE_Declare,0);
   double rsiBeforeValue = iRSI(NULL,Trade_TIMEFRAME,rsiPeriod,PRICE_Declare,1);
   Alert("Current RSI : ",NormalizeDouble(rsiCurrentValue,2));
   Alert("Before RSI : ",NormalizeDouble(rsiBeforeValue,2));
   if(rsiCurrentValue > 30 && rsiBeforeValue < 30)
     {
      //buy order 
     }
   else if(rsiCurrentValue < 70 && rsiBeforeValue > 70)
     {
      //sell order      
     }
}

void _macdCheck()
{
   double macDValue = iMACD(NULL,Trade_TIMEFRAME,FastEMAmAcD,SlowEMAmAcD,SignalSMAmAcD,PRICE_Declare,0,0);
   double macDsignalValue = iMACD(NULL,Trade_TIMEFRAME,FastEMAmAcD,SlowEMAmAcD,SignalSMAmAcD,PRICE_Declare,1,0);
   
   Alert("First MACD = ",NormalizeDouble(macDValue,4));
   Alert("First MACD Signal = ",NormalizeDouble(macDsignalValue,4));
   
   double macDValue2 = iMACD(NULL,Trade_TIMEFRAME,FastEMAmAcD,SlowEMAmAcD,SignalSMAmAcD,PRICE_Declare,0,1);
   double macDsignalValue2 = iMACD(NULL,Trade_TIMEFRAME,FastEMAmAcD,SlowEMAmAcD,SignalSMAmAcD,PRICE_Declare,1,1);
   
   Alert("Second MACD = ",NormalizeDouble(macDValue2,4));
   Alert("Second MACD Signal = ",NormalizeDouble(macDsignalValue2,4));
   
   if(macDValue < macDsignalValue && macDValue + macDsignalValue >= (-300))
     {
      Alert("Hello"); //Buy signal
     }
   else if(macDValue > macDsignalValue && macDsignalValue + macDValue >= (-300))
     {
      Alert("Bye");  //Sell Signal
     }
}

void _volumeCheck()
{
      int firstVolume = iVolume(NULL,Trade_TIMEFRAME,0);
      Alert("1 volume is : ",firstVolume);
      int SecondVolume = iVolume(NULL,Trade_TIMEFRAME,1);
      Alert("2 volume is : ",SecondVolume);
      int ThirdVolume = iVolume(NULL,Trade_TIMEFRAME,2);
      Alert("3 volume is : ",ThirdVolume);
}

//void _stoCheck()
//{
  //    double stock = iStochastic(NULL,Trade_TIMEFRAME,
//}
