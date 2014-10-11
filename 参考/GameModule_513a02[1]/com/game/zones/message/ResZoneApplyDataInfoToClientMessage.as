package com.game.zones.message
{
    import com.game.zones.bean.*;
    import net.*;

    public class ResZoneApplyDataInfoToClientMessage extends Message
    {
        private var _zoneapplydatainfo:ZoneApplyDataInfo;
        private var _type:int;

        public function ResZoneApplyDataInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._zoneapplydatainfo);
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneapplydatainfo = readBean(ZoneApplyDataInfo) as ZoneApplyDataInfo;
            this._type = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128120;
        }// end function

        public function get zoneapplydatainfo() : ZoneApplyDataInfo
        {
            return this._zoneapplydatainfo;
        }// end function

        public function set zoneapplydatainfo(param1:ZoneApplyDataInfo) : void
        {
            this._zoneapplydatainfo = param1;
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
