package com.game.zones.message
{
    import com.game.zones.bean.*;
    import net.*;

    public class ResZonePanelSelectMessage extends Message
    {
        private var _raidzoneinfolist:RaidZoneInfo;
        private var _manualstatus:int;
        private var _autostatus:int;

        public function ResZonePanelSelectMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._raidzoneinfolist);
            writeInt(this._manualstatus);
            writeInt(this._autostatus);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._raidzoneinfolist = readBean(RaidZoneInfo) as RaidZoneInfo;
            this._manualstatus = readInt();
            this._autostatus = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128101;
        }// end function

        public function get raidzoneinfolist() : RaidZoneInfo
        {
            return this._raidzoneinfolist;
        }// end function

        public function set raidzoneinfolist(param1:RaidZoneInfo) : void
        {
            this._raidzoneinfolist = param1;
            return;
        }// end function

        public function get manualstatus() : int
        {
            return this._manualstatus;
        }// end function

        public function set manualstatus(param1:int) : void
        {
            this._manualstatus = param1;
            return;
        }// end function

        public function get autostatus() : int
        {
            return this._autostatus;
        }// end function

        public function set autostatus(param1:int) : void
        {
            this._autostatus = param1;
            return;
        }// end function

    }
}
