package com.game.guild.message
{
    import __AS3__.vec.*;
    import com.game.guild.bean.*;
    import net.*;

    public class ResGuildGetEventListToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _eventList:Vector.<EventInfo>;
        private var _contributionList:Vector.<ContributionInfo>;

        public function ResGuildGetEventListToClientMessage()
        {
            this._eventList = new Vector.<EventInfo>;
            this._contributionList = new Vector.<ContributionInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._btErrorCode);
            writeShort(this._eventList.length);
            _loc_1 = 0;
            while (_loc_1 < this._eventList.length)
            {
                
                writeBean(this._eventList[_loc_1]);
                _loc_1++;
            }
            writeShort(this._contributionList.length);
            _loc_1 = 0;
            while (_loc_1 < this._contributionList.length)
            {
                
                writeBean(this._contributionList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._btErrorCode = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._eventList[_loc_1] = readBean(EventInfo) as EventInfo;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._contributionList[_loc_1] = readBean(ContributionInfo) as ContributionInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 121121;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

        public function get eventList() : Vector.<EventInfo>
        {
            return this._eventList;
        }// end function

        public function set eventList(param1:Vector.<EventInfo>) : void
        {
            this._eventList = param1;
            return;
        }// end function

        public function get contributionList() : Vector.<ContributionInfo>
        {
            return this._contributionList;
        }// end function

        public function set contributionList(param1:Vector.<ContributionInfo>) : void
        {
            this._contributionList = param1;
            return;
        }// end function

    }
}
