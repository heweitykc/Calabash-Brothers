package com.game.role
{
    import com.f1.utils.path.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class FollowerRole extends Role
    {
        private var _parentPath:Array;
        private var _lastPickTime:Number = 0;

        public function FollowerRole()
        {
            return;
        }// end function

        public function flyToParent() : void
        {
            var _loc_1:* = null;
            _loc_1 = RoleList.getInstance().player;
            if (_loc_1)
            {
                x = _loc_1._x + MapUtils.GRID_BORDER * 4;
                y = _loc_1._y + MapUtils.GRID_BORDER * 4;
                this.arrive();
            }
            return;
        }// end function

        private function backToParent() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = RoleList.getInstance().player;
            if (_loc_1)
            {
                if (this._parentPath && this._parentPath.length)
                {
                    _loc_2 = this._parentPath[(this._parentPath.length - 1)];
                }
                else
                {
                    _loc_3 = MapControl.getInstance().getRandomNearRoadGrid(MapUtils.coo2Tile(_loc_1._x), MapUtils.coo2Tile(_loc_1._y), 3);
                    if (_loc_3)
                    {
                        _loc_2 = MapUtils.tile2Coo([_loc_3.x, _loc_3.y]);
                    }
                }
                if (_loc_2 && _loc_2.length)
                {
                    this.pathByCoo(_loc_2[0], _loc_2[1]);
                }
            }
            return;
        }// end function

        public function moveToParent(param1:Array) : void
        {
            this._parentPath = param1;
            this.backToParent();
            return;
        }// end function

        override protected function arrive() : void
        {
            super.arrive();
            if (this._parentPath)
            {
                this._parentPath.splice(0, this._parentPath.length);
            }
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            super.enterFrame(event);
            var _loc_2:* = getTimer();
            var _loc_3:* = 1000;
            if (_loc_2 - this._lastPickTime >= _loc_3)
            {
                this.checkDisWithParent();
            }
            return;
        }// end function

        private function checkDisWithParent() : void
        {
            var _loc_1:* = RoleList.getInstance().player;
            if (_loc_1)
            {
                if (Math.abs(_loc_1._x - _x) > Params.CUTE_PET_WALK_MAX_RANGE || Math.abs(_loc_1._y - _y) > Params.CUTE_PET_WALK_MAX_RANGE)
                {
                    this.flyToParent();
                }
                else if (Math.abs(x - _loc_1._x) > 200 || Math.abs(y - _loc_1._y) > 200)
                {
                    this.backToParent();
                }
            }
            return;
        }// end function

        override public function pathByCoo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = true, param7:Boolean = false, param8:Boolean = true) : Boolean
        {
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_9:* = MapObj.getInstance().tilesba;
            var _loc_10:* = MapUtils.coo2Tile(x);
            var _loc_11:* = MapUtils.coo2Tile(y);
            var _loc_12:* = MapUtils.coo2Tile(param1);
            var _loc_13:* = MapUtils.coo2Tile(param2);
            var _loc_14:* = MapUtils.findPath(_loc_9, _loc_10, _loc_11, _loc_12, _loc_13, param3);
            if (MapUtils.findPath(_loc_9, _loc_10, _loc_11, _loc_12, _loc_13, param3) && _loc_14.length)
            {
                _loc_15 = [];
                if (param3 == 0)
                {
                    _loc_16 = _loc_14.length - 2;
                    _loc_17 = 1;
                    while (_loc_17 < _loc_16)
                    {
                        
                        _loc_15.push(MapUtils.tile2Coo(_loc_14[_loc_17]));
                        _loc_17 = _loc_17 + 1;
                    }
                    _loc_15.push([param1, param2]);
                }
                else
                {
                    _loc_16 = _loc_14.length - 1;
                    _loc_17 = 1;
                    while (_loc_17 < _loc_16)
                    {
                        
                        _loc_15.push(MapUtils.tile2Coo(_loc_14[_loc_17]));
                        _loc_17 = _loc_17 + 1;
                    }
                }
                return pathByAStarArray(_loc_15);
            }
            return false;
        }// end function

    }
}
