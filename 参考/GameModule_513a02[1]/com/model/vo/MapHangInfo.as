package com.model.vo
{
    import com.cfg.obj.*;

    public class MapHangInfo extends Object
    {
        public var index:uint;
        private var _mapName:String;
        public var monInfoList:Array;
        public var q_parameter:uint;
        public var q_monster_attack:uint;
        public var q_monster_level:uint;
        private var _mapLimitMinLv:int;
        private var _mapLimitMaxLv:int;
        private var isInitMapInfo:Boolean;

        public function MapHangInfo(param1:Object)
        {
            var _loc_5:* = null;
            this.index = param1.q_id;
            var _loc_2:* = param1.q_monster_coord.split(";");
            var _loc_3:* = 0;
            var _loc_4:* = _loc_2.length;
            this.monInfoList = [];
            if (param1.q_monster_coord != "")
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_5 = new WorldMapMonInfo();
                    _loc_5.conByHangUpMapMonObjStr(_loc_2[_loc_3]);
                    this.monInfoList.push(_loc_5);
                    _loc_3++;
                }
            }
            this.q_parameter = param1.q_parameter;
            this.q_monster_attack = param1.q_monster_attack;
            this.q_monster_level = param1.q_monster_level;
            return;
        }// end function

        private function initHangInfo() : void
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(this.index);
            this._mapLimitMinLv = _loc_1.mapLimitMinLv;
            this._mapLimitMaxLv = _loc_1.mapLimitMaxLv;
            this.isInitMapInfo = true;
            return;
        }// end function

        public function get mapName() : String
        {
            if (!this.isInitMapInfo)
            {
                this.initHangInfo();
            }
            return this._mapName;
        }// end function

        public function set mapName(param1:String) : void
        {
            this._mapName = param1;
            return;
        }// end function

        public function get mapLimitMinLv() : int
        {
            if (!this.isInitMapInfo)
            {
                this.initHangInfo();
            }
            return this._mapLimitMinLv;
        }// end function

        public function set mapLimitMinLv(param1:int) : void
        {
            this._mapLimitMinLv = param1;
            return;
        }// end function

        public function get mapLimitMaxLv() : int
        {
            if (!this.isInitMapInfo)
            {
                this.initHangInfo();
            }
            return this._mapLimitMaxLv;
        }// end function

        public function set mapLimitMaxLv(param1:int) : void
        {
            this._mapLimitMaxLv = param1;
            return;
        }// end function

    }
}
