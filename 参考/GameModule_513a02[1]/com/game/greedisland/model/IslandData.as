package com.game.greedisland.model
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.greedisland.events.*;
    import com.game.prompt.utils.*;
    import com.game.zones.control.*;
    import com.game.zones.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.geom.*;

    public class IslandData extends BaseEventDispatcher
    {
        private var _hasEnterTime:int = 0;
        private var _maxEnterTime:int = 2;
        private var _electments1:Vector.<Object>;
        private var _electments2:Vector.<Object>;
        private var _electments3:Vector.<Object>;
        private var _electments4:Vector.<Object>;
        private var _totalExp:int = 0;
        public static var COPY_TIME:int = 600;
        private static var _instance:IslandData;

        public function IslandData()
        {
            return;
        }// end function

        public function get hasEnterTime() : int
        {
            return this._hasEnterTime;
        }// end function

        public function set hasEnterTime(param1:int) : void
        {
            this._hasEnterTime = param1;
            return;
        }// end function

        public function get maxEnterTime() : int
        {
            return this._maxEnterTime;
        }// end function

        public function set maxEnterTime(param1:int) : void
        {
            this._maxEnterTime = param1;
            return;
        }// end function

        public function getCopyLeftNum() : int
        {
            var _loc_1:* = ZonesModel.getInstance().getCopyLeftNum(Params.ISLAND_COPY_ID);
            return _loc_1;
        }// end function

        public function checkIsElementHeart(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(param1);
            if (_loc_3 && _loc_3.q_type == ItemType.ELEMENT_HEART)
            {
                _loc_4 = ZonesControl.getInstance().islandTrace.box1point;
                _loc_5 = ZonesControl.getInstance().islandTrace.box2point;
                _loc_6 = ZonesControl.getInstance().islandTrace.box3point;
                _loc_7 = ZonesControl.getInstance().islandTrace.box4point;
                _loc_4.x = _loc_4.x - 25;
                _loc_4.y = _loc_4.y - 25;
                _loc_5.x = _loc_5.x - 25;
                _loc_5.y = _loc_5.y - 25;
                _loc_6.x = _loc_6.x - 25;
                _loc_6.y = _loc_6.y - 25;
                _loc_7.x = _loc_7.x - 25;
                _loc_7.y = _loc_7.y - 25;
                _loc_8 = QEHeartCfgObj.getInstance().getItem(_loc_3.q_value);
                if (_loc_8)
                {
                    _loc_9 = new Object();
                    _loc_9.modelId = param1;
                    _loc_9.num = param2;
                    _loc_9.q_swallow = _loc_8.q_swallow;
                    if (_loc_8.q_quality == 4)
                    {
                        this._electments1.push(_loc_9);
                        _loc_9.kind = 1;
                        if (_loc_4.x != -25)
                        {
                            ItemGetAnim.doFlyGetItemToIslandBack(param1, _loc_4);
                        }
                    }
                    else if (_loc_8.q_quality == 3)
                    {
                        this._electments2.push(_loc_9);
                        _loc_9.kind = 2;
                        if (_loc_5.x != -25)
                        {
                            ItemGetAnim.doFlyGetItemToIslandBack(param1, _loc_5);
                        }
                    }
                    else if (_loc_8.q_quality == 2)
                    {
                        this._electments3.push(_loc_9);
                        _loc_9.kind = 3;
                        if (_loc_6.x != -25)
                        {
                            ItemGetAnim.doFlyGetItemToIslandBack(param1, _loc_6);
                        }
                    }
                    else if (_loc_8.q_quality == 1)
                    {
                        this._electments4.push(_loc_9);
                        _loc_9.kind = 4;
                        if (_loc_7.x != -25)
                        {
                            ItemGetAnim.doFlyGetItemToIslandBack(param1, _loc_7);
                        }
                    }
                    this._totalExp = this._totalExp + _loc_8.q_swallow;
                    dispatchEvt(new IslandEvent(IslandEvent.ISLAND_ELECMENTS_DATA_CHANGE));
                }
            }
            return;
        }// end function

        public function resetElementHeart() : void
        {
            this._electments1 = new Vector.<Object>;
            this._electments2 = new Vector.<Object>;
            this._electments3 = new Vector.<Object>;
            this._electments4 = new Vector.<Object>;
            this._totalExp = 0;
            return;
        }// end function

        public function get electments1() : Vector.<Object>
        {
            return this._electments1;
        }// end function

        public function set electments1(param1:Vector.<Object>) : void
        {
            this._electments1 = param1;
            return;
        }// end function

        public function get electments2() : Vector.<Object>
        {
            return this._electments2;
        }// end function

        public function set electments2(param1:Vector.<Object>) : void
        {
            this._electments2 = param1;
            return;
        }// end function

        public function get electments3() : Vector.<Object>
        {
            return this._electments3;
        }// end function

        public function set electments3(param1:Vector.<Object>) : void
        {
            this._electments3 = param1;
            return;
        }// end function

        public function get electments4() : Vector.<Object>
        {
            return this._electments4;
        }// end function

        public function set electments4(param1:Vector.<Object>) : void
        {
            this._electments4 = param1;
            return;
        }// end function

        public function get totalExp() : int
        {
            return this._totalExp;
        }// end function

        public function set totalExp(param1:int) : void
        {
            this._totalExp = param1;
            return;
        }// end function

        public static function getInstance() : IslandData
        {
            if (_instance == null)
            {
                _instance = new IslandData;
            }
            return _instance;
        }// end function

    }
}
