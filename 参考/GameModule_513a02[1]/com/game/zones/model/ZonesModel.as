package com.game.zones.model
{
    import __AS3__.vec.*;
    import com.game.zones.message.*;
    import flash.events.*;

    public class ZonesModel extends EventDispatcher
    {
        private var _raidzoneinfolist:Vector.<RaidZoneInfo>;
        private var _zonesAwardsInfo:ResZonePassShowMessage;
        private var _zoneTeamInfo:Vector.<ZoneTeamInfo>;
        private var _zoneTeamSelectInfo:Vector.<ResZoneTeamNoticeSelectToClientMessage>;
        private var _zoneid:int;
        public var dekaronInfo:ResTowerIndexMessage;
        public var dekaronGiftInfo:ResTowerRewardSurplusMessage;
        public var isInstance:Boolean = false;
        public var killMonsterCount:int = 0;
        public var killMonsterGetExp:Number = 0;
        public var isWolfSoulAct:Boolean;
        public static var COPY_TIMES_CHANGE:String = "copyTimesChange";
        public static const ZONES_XS:int = 2;
        private static var _instance:ZonesModel;

        public function ZonesModel()
        {
            this._zoneTeamSelectInfo = new Vector.<ResZoneTeamNoticeSelectToClientMessage>;
            return;
        }// end function

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function setRaidZoneInfo(param1:Vector.<RaidZoneInfo>) : void
        {
            this._raidzoneinfolist = param1;
            return;
        }// end function

        public function get raidzoneinfolist() : Vector.<RaidZoneInfo>
        {
            return this._raidzoneinfolist;
        }// end function

        public function set raidzoneinfolist(param1:Vector.<RaidZoneInfo>) : void
        {
            this._raidzoneinfolist = param1;
            return;
        }// end function

        public function get zonesAwardsInfo() : ResZonePassShowMessage
        {
            return this._zonesAwardsInfo;
        }// end function

        public function set zonesAwardsInfo(param1:ResZonePassShowMessage) : void
        {
            this._zonesAwardsInfo = param1;
            return;
        }// end function

        public function get zoneTeamSelectInfo() : Vector.<ResZoneTeamNoticeSelectToClientMessage>
        {
            return this._zoneTeamSelectInfo;
        }// end function

        public function set zoneTeamSelectInfo(param1:Vector.<ResZoneTeamNoticeSelectToClientMessage>) : void
        {
            this._zoneTeamSelectInfo = param1;
            return;
        }// end function

        public function get zoneTeamAllInfo() : Vector.<ZoneTeamInfo>
        {
            return this._zoneTeamInfo;
        }// end function

        public function set zoneTeamAllInfo(param1:Vector.<ZoneTeamInfo>) : void
        {
            this._zoneTeamInfo = param1;
            dispatchEvent(new Event(COPY_TIMES_CHANGE));
            return;
        }// end function

        public function cleanTeamSelectInfo() : void
        {
            while (this._zoneTeamSelectInfo.length > 0)
            {
                
                this._zoneTeamSelectInfo.pop();
            }
            return;
        }// end function

        public function getCopyLeftNum(param1:int) : int
        {
            var _loc_2:* = 0;
            while (this._zoneTeamInfo && _loc_2 < this._zoneTeamInfo.length)
            {
                
                if (this._zoneTeamInfo[_loc_2].zoneid == param1)
                {
                    return this._zoneTeamInfo[_loc_2].enterMaxnum - this._zoneTeamInfo[_loc_2].enternum;
                }
                _loc_2++;
            }
            return 0;
        }// end function

        public static function getInstance() : ZonesModel
        {
            if (!_instance)
            {
                _instance = new ZonesModel;
            }
            return _instance;
        }// end function

    }
}
