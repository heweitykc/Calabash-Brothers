package com.game.team.message
{
    import __AS3__.vec.*;
    import com.game.team.bean.*;
    import net.*;

    public class ResMapSearchTeamInfoClientMessage extends Message
    {
        private var _mapteaminfo:Vector.<MapTeamInfo>;

        public function ResMapSearchTeamInfoClientMessage()
        {
            this._mapteaminfo = new Vector.<MapTeamInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._mapteaminfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._mapteaminfo.length)
            {
                
                writeBean(this._mapteaminfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._mapteaminfo[_loc_1] = readBean(MapTeamInfo) as MapTeamInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 118108;
        }// end function

        public function get mapteaminfo() : Vector.<MapTeamInfo>
        {
            return this._mapteaminfo;
        }// end function

        public function set mapteaminfo(param1:Vector.<MapTeamInfo>) : void
        {
            this._mapteaminfo = param1;
            return;
        }// end function

    }
}
