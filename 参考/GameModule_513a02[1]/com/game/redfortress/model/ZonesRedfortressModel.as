package com.game.redfortress.model
{
    import __AS3__.vec.*;
    import com.game.redfortress.bean.*;
    import com.game.utils.*;
    import com.game.zones.message.*;
    import com.model.*;

    public class ZonesRedfortressModel extends Object
    {
        public var zonesPassInfo:ResZonePassShowMessage;
        public var zonesRankList:Vector.<CsysTopInfo>;
        public var zonesSelfRank:CsysTopInfo;
        public static var ZONES_ID:int = 6001;
        private static var _instance:ZonesRedfortressModel;

        public function ZonesRedfortressModel()
        {
            return;
        }// end function

        public function set zonesRankInfo(param1:Vector.<CsysTopInfo>) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = param1.length;
            if (_loc_2 <= 5)
            {
                this.zonesRankList = param1;
            }
            else
            {
                this.zonesRankList = param1.slice(0, 5);
            }
            var _loc_3:* = UserObj.getInstance().playerInfo.personId;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1[_loc_4];
                if (_loc_5.playerid.equal(_loc_3))
                {
                    this.zonesSelfRank = _loc_5;
                    return;
                }
                _loc_4++;
            }
            return;
        }// end function

        public static function getInstance() : ZonesRedfortressModel
        {
            if (!_instance)
            {
                _instance = new ZonesRedfortressModel;
            }
            return _instance;
        }// end function

        public static function getVirturalModelId(param1:int) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = (param1 - 1) % 3 + 1;
            switch(_loc_3)
            {
                case 1:
                {
                    _loc_2 = "ms137";
                    break;
                }
                case 2:
                {
                    _loc_2 = "ms136";
                    break;
                }
                case 3:
                {
                    _loc_2 = "ms141";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
