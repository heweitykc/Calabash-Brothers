package com.game.bank.message
{
    import __AS3__.vec.*;
    import com.game.bank.bean.*;
    import net.*;

    public class ResQueryBankLogMessage extends Message
    {
        private var _bankLogs:Vector.<BankLogInfo>;
        private var _count:int;

        public function ResQueryBankLogMessage()
        {
            this._bankLogs = new Vector.<BankLogInfo>;
            return;
        }// end function

        public function set bankLogs(param1:Vector.<BankLogInfo>) : void
        {
            this._bankLogs = param1;
            return;
        }// end function

        public function get bankLogs() : Vector.<BankLogInfo>
        {
            return this._bankLogs;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        override public function getId() : int
        {
            return 510202;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._bankLogs.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._bankLogs.length)
            {
                
                writeBean(this._bankLogs[_loc_1]);
                _loc_1++;
            }
            writeInt(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._bankLogs[_loc_2] = readBean(BankLogInfo) as BankLogInfo;
                _loc_2++;
            }
            this._count = readInt();
            return true;
        }// end function

    }
}
