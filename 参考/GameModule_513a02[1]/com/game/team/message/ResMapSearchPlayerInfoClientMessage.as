package com.game.team.message
{
    import __AS3__.vec.*;
    import com.game.team.bean.*;
    import net.*;

    public class ResMapSearchPlayerInfoClientMessage extends Message
    {
        private var _mapplayerinfo:Vector.<MapPlayerInfo>;

        public function ResMapSearchPlayerInfoClientMessage()
        {
            this._mapplayerinfo = new Vector.<MapPlayerInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._mapplayerinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._mapplayerinfo.length)
            {
                
                writeBean(this._mapplayerinfo[_loc_1]);
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
                
                this._mapplayerinfo[_loc_1] = readBean(MapPlayerInfo) as MapPlayerInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 118109;
        }// end function

        public function get mapplayerinfo() : Vector.<MapPlayerInfo>
        {
            return this._mapplayerinfo;
        }// end function

        public function set mapplayerinfo(param1:Vector.<MapPlayerInfo>) : void
        {
            this._mapplayerinfo = param1;
            return;
        }// end function

    }
}
