package com.game.mail.message
{
    import __AS3__.vec.*;
    import com.game.mail.bean.*;
    import net.*;

    public class ResMailQueryListToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _count:int;
        private var _indexLarge:int;
        private var _mailSummaryList:Vector.<MailSummaryInfo>;

        public function ResMailQueryListToClientMessage()
        {
            this._mailSummaryList = new Vector.<MailSummaryInfo>;
            return;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
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

        public function set indexLarge(param1:int) : void
        {
            this._indexLarge = param1;
            return;
        }// end function

        public function get indexLarge() : int
        {
            return this._indexLarge;
        }// end function

        public function set mailSummaryList(param1:Vector.<MailSummaryInfo>) : void
        {
            this._mailSummaryList = param1;
            return;
        }// end function

        public function get mailSummaryList() : Vector.<MailSummaryInfo>
        {
            return this._mailSummaryList;
        }// end function

        override public function getId() : int
        {
            return 124101;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeShort(this._mailSummaryList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._mailSummaryList.length)
            {
                
                writeBean(this._mailSummaryList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._mailSummaryList[_loc_2] = readBean(MailSummaryInfo) as MailSummaryInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
