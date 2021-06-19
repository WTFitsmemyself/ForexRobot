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
   IsTradeallowed();
   _BAlance_Acc();
   _CheckLot();
   _CheckPip();
   _checkBars();
   _Trade_Method();
   _mavaLue();
   _rsiCheck();
   _macdCheck();
   _volumeCheck();
   _BBCheck();
   _getTakeProfit(ItIsALongPosition);
   _getStopLoss(ItIsALongPosition);
   
   
  
   }
//+------------------------------------------------------------------+

input bool ItIsALongPosition = true;
input int Moving_Average_Period = 21; 
input int rsiPeriod = 14;
input ENUM_TIMEFRAMES Trade_TIMEFRAME = 60;
input ENUM_MA_METHOD Moving_Average_METHOD = 1;
input ENUM_APPLIED_PRICE PRICE_Declare = 5;
input int FastEMAmAcD = 12;
input int SlowEMAmAcD = 26;
input int SignalSMAmAcD = 9;
input int BBperid = 20;
input double BBdeviason = 1.0 ;
input double BBdeviason2 = 4.0 ;

double pipValue;
double bblower1 = iBands(NULL,0,BBperid,BBdeviason,0,PRICE_CLOSE,2,0);
double bbupper1 = iBands(NULL,0,BBperid,BBdeviason,0,PRICE_CLOSE,1,0);
double bbmid1 = iBands(NULL,0,BBperid,BBdeviason,0,PRICE_CLOSE,0,0);
double bblower2 = iBands(NULL,0,BBperid,BBdeviason2,0,PRICE_CLOSE,2,0);
double bbupper2 = iBands(NULL,0,BBperid,BBdeviason2,0,PRICE_CLOSE,1,0);
double LotSize = SymbolInfoDouble(NULL,SYMBOL_TRADE_CONTRACT_SIZE);
double MinLotSize = MarketInfo(NULL,23);




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
     Alert("MAX Stop Loss is :",StopLossPricee);
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
     Alert("MAX Take Profit is :",TakeProfitPricee);
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
      Alert("MACD say to Buy"); //Buy signal
      int orderID = OrderSend(NULL,OP_BUYLIMIT,LotSize,Ask,10,stopLossPrice,takeProfitPrice);
         if(orderID < 0)
     {
      Alert("Can't Open Sell Position, OrderERROR is  : ",GetLastError());
     }
   else if(orderID == 0)
     {
      Alert("Can't Open Sell Position, Market is Closed, OrderERROR is : ",GetLastError());
     }
   else
     {
      Alert("Open Sell Position Successfully With This Ticker Number : ",orderID);
     }
     }
   else if(macDValue > macDsignalValue && macDsignalValue + macDValue >= (-300))
     {
      Alert("MACD say to Sell");  //Sell Signal
      int orderID = OrderSend(NULL,OP_SELLLIMIT,LotSize,Bid,10,stopLossPrice,takeProfitPrice);
   if(orderID < 0)
     {
      Alert("Can't Open Sell Position, OrderERROR is  : ",GetLastError());
     }
   else if(orderID == 0)
     {
      Alert("Can't Open Sell Position, Market is Closed, OrderERROR is : ",GetLastError());
     }
   else
     {
      Alert("Open Sell Position Successfully With This Ticker Number : ",orderID);
     }
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


void _BBCheck()
{
if(Ask < bblower1)//buying
  {
  Alert("Price is bellow bblower1 , Sending Buy order");
   double stopLossPrice = bblower2;
   double takeProfitPrice = bbmid1;
   Alert("Entry Price is : ",Ask);
   Alert("Stop Loss is : ",MathRound(NormalizeDouble(stopLossPrice,_Digits)));
   Alert("Take profit is : ",MathRound(NormalizeDouble(takeProfitPrice,_Digits)));
   int orderID = OrderSend(NULL,OP_BUYLIMIT,LotSize,Ask,10,stopLossPrice,takeProfitPrice);
   if(orderID < 0)
     {
      Alert("Can't Open Buy Position OrderERROR is : ",GetLastError());
     }
   else if(orderID == 0)
     {
      Alert("Can't Open Sell Position, Market is Closed OrderERROR is : ",GetLastError());
     }
   else
     {
      Alert("Open Buy Position Successfully With This Ticker Number : ",orderID);
     }
  }
  
  
  
else if(Bid > bbupper1)//selling
  {
  Alert("Price is upper that bbupper1 , Sending Sell order");
   double stopLossPrice = bbupper2;
   double takeProfitPrice = bbmid1;
   Alert("Entry Price is : ",Bid);
   Alert("Stop Loss is : ",MathRound(NormalizeDouble(stopLossPrice,_Digits)));
   Alert("Take profit is : ",MathRound(NormalizeDouble(takeProfitPrice,_Digits)));
   int orderID = OrderSend(NULL,OP_SELLLIMIT,LotSize,Bid,10,stopLossPrice,takeProfitPrice);
   if(orderID < 0)
     {
      Alert("Can't Open Sell Position, OrderERROR is  : ",GetLastError());
     }
   else if(orderID == 0)
     {
      Alert("Can't Open Sell Position, Market is Closed, OrderERROR is : ",GetLastError());
     }
   else
     {
      Alert("Open Sell Position Successfully With This Ticker Number : ",orderID);
     }
  }
}


bool IsTradeallowed()
{
   if(!IsTradeAllowed())
     {
      Alert("Expert Advisor Can't run, Please check Auto Trading option");
      return false;
     }
   else if(!IsTradeAllowed(Symbol(),TimeCurrent()))
     {
        Alert("Expert Advisor Can't run, Because of the current symbol or the current time");    
        return false;
     }
   else
     {
        return true;
     }
}


void _CheckLot()
{
    Alert("Lot Size of account is : ",LotSize);
    Alert("Minimum Lot Size of account is : ",MinLotSize);
}


