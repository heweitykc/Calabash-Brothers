package com.game.mail.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class MailSummaryInfo extends Bean
    {
        private var _mailid:long;
        private var _szSenderName:String;
        private var _szTitle:String;
        private var _btRead:int;
        private var _btAccessory:int;
        private var _nSendTime:int;
        private var _btSystem:int;
        private var _summaryitemlist:Vector.<MailSummaryItem>;

        public function MailSummaryInfo()
        {
            this._summaryitemlist = new Vector.<MailSummaryItem>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._mailid);
            writeString(this._szSenderName);
            writeString(this._szTitle);
            writeByte(this._btRead);
            writeByte(this._btAccessory);
            writeInt(this._nSendTime);
            writeByte(this._btSystem);
            writeShort(this._summaryitemlist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._summaryitemlist.length)
            {
                
                writeBean(this._summaryitemlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mailid = readLong();
            this._szSenderName = readString();
            this._szTitle = readString();
            this._btRead = readByte();
            this._btAccessory = readByte();
            this._nSendTime = readInt();
            this._btSystem = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._summaryitemlist[_loc_2] = readBean(MailSummaryItem) as MailSummaryItem;
                _loc_2++;
            }
            return true;
        }// end function

        public function get mailid() : long
        {
            return this._mailid;
        }// end function

        public function set mailid(param1:long) : void
        {
            this._mailid = param1;
            return;
        }// end function

        public function get szSenderName() : String
        {
            return this._szSenderName;
        }// end function

        public function set szSenderName(param1:String) : void
        {
            this._szSenderName = param1;
            return;
        }// end function

        public function get szTitle() : String
        {
            return this._szTitle;
        }// end function

        public function set szTitle(param1:String) : void
        {
            this._szTitle = param1;
            return;
        }// end function

        public function get btRead() : int
        {
            return this._btRead;
        }// end function

        public function set btRead(param1:int) : void
        {
            this._btRead = param1;
            return;
        }// end function

        public function get btAccessory() : int
        {
            return this._btAccessory;
        }// end function

        public function set btAccessory(param1:int) : void
        {
            this._btAccessory = param1;
            return;
        }// end function

        public function get nSendTime() : int
        {
            return this._nSendTime;
        }// end function

        public function set nSendTime(param1:int) : void
        {
            this._nSendTime = param1;
            return;
        }// end function

        public function get btSystem() : int
        {
            return this._btSystem;
        }// end function

        public function set btSystem(param1:int) : void
        {
            this._btSystem = param1;
            return;
        }// end function

        public function get summaryitemlist() : Vector.<MailSummaryItem>
        {
            return this._summaryitemlist;
        }// end function

        public function set summaryitemlist(param1:Vector.<MailSummaryItem>) : void
        {
            this._summaryitemlist = param1;
            return;
        }// end function

    }
}
