package com.game.bank.events
{
    import flash.events.*;

    public class BankEvent extends Event
    {
        public var data:Object;
        public static const MONTH_BANK_CHANGE:String = "monthBankChange";
        public static const UP_BANK_CHANGE:String = "mupBankChange";
        public static const BANK_HISTORY_CHANGE:String = "bankHistoryChange";

        public function BankEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new BankEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
