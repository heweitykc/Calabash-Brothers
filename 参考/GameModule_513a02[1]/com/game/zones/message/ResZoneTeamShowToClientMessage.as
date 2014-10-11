package com.game.zones.message
{
    import __AS3__.vec.*;
    import com.game.zones.bean.*;
    import net.*;

    public class ResZoneTeamShowToClientMessage extends Message
    {
        private var _zoneteaminfo:Vector.<ZoneTeamInfo>;
        private var _type:int;

        public function ResZoneTeamShowToClientMessage()
        {
            this._zoneteaminfo = new Vector.<ZoneTeamInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._zoneteaminfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._zoneteaminfo.length)
            {
                
                writeBean(this._zoneteaminfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._zoneteaminfo[_loc_1] = readBean(ZoneTeamInfo) as ZoneTeamInfo;
                _loc_1++;
            }
            this._type = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128116;
        }// end function

        public function get zoneteaminfo() : Vector.<ZoneTeamInfo>
        {
            return this._zoneteaminfo;
        }// end function

        public function set zoneteaminfo(param1:Vector.<ZoneTeamInfo>) : void
        {
            this._zoneteaminfo = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
