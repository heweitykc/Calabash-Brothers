package com.game.role.view
{
    import com.f1.utils.path.*;
    import com.game.backpack.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class PlayerCutePet extends CutePet
    {
        private var _lastPickTime:Number = 0;
        private var _lastCheckTime:Number = 0;
        private var _lastMovePickX:Number = 0;
        private var _lastMovePickY:Number = 0;
        private var _parentPath:Array;
        private var _state:int;

        public function PlayerCutePet()
        {
            this.state = Params.CUTE_PET_NORMAL;
            return;
        }// end function

        override public function flyToParent() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (!_info || !CutePetInfo(_info).parentId)
            {
                return;
            }
            _loc_1 = RoleList.getInstance().getRole(CutePetInfo(_info).parentId);
            if (_loc_1)
            {
                _loc_2 = 5;
                _loc_3 = 5;
                while (_loc_3 >= -5)
                {
                    
                    while (_loc_2 >= -5)
                    {
                        
                        _loc_4 = MapUtils.coo2Tile(_loc_1._x);
                        _loc_5 = MapUtils.coo2Tile(_loc_1._y);
                        if (!MapObj.getInstance().isObstacle(_loc_4 + _loc_2, _loc_5 + _loc_3))
                        {
                            x = _loc_1._x + MapUtils.GRID_BORDER * _loc_2;
                            y = _loc_1._y + MapUtils.GRID_BORDER * _loc_3;
                            this.arrive();
                            return;
                        }
                        _loc_2 = _loc_2 - 1;
                    }
                    _loc_3 = _loc_3 - 1;
                }
                x = _loc_1._x;
                y = _loc_1._y;
            }
            return;
        }// end function

        private function returnToParent() : void
        {
            var _loc_1:* = null;
            _loc_1 = RoleList.getInstance().getRole(CutePetInfo(_info).parentId);
            x = _loc_1._x;
            y = _loc_1._y;
            return;
        }// end function

        private function backToParent() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.state != Params.CUTE_PET_MOVE_TO_DROP && this.state != Params.CUTE_PET_FOLLOW)
            {
                _loc_1 = RoleList.getInstance().getRole(CutePetInfo(_info).parentId);
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
                        if (this.pathByCoo(_loc_2[0], _loc_2[1]))
                        {
                            this.state = Params.CUTE_PET_FOLLOW;
                        }
                        else
                        {
                            this.flyToParent();
                        }
                    }
                }
            }
            return;
        }// end function

        override public function moveToParent(param1:Array) : void
        {
            this._parentPath = param1;
            if (this.state == Params.CUTE_PET_FOLLOW)
            {
                this.backToParent();
            }
            return;
        }// end function

        override protected function arrive() : void
        {
            var _loc_1:* = null;
            super.arrive();
            if (BackpackObj.getInstance().isFull() && !MapControl.getInstance().jugeElementIsPick())
            {
                _loc_1 = Params.PICK_LIST_WITH_BAG_FULL;
            }
            MapControl.getInstance().dropTakeUpGoodsWithRange(x, y, 10 * MapUtils.GRID_BORDER, Params.DROP_CUTE_PET_PICK_LIMIT, false, _loc_1, true);
            var _loc_2:* = this.state;
            this.state = Params.CUTE_PET_NORMAL;
            if (_loc_2 == Params.CUTE_PET_MOVE_TO_DROP)
            {
                this.checkDisWithParent(getTimer());
            }
            else if (this._parentPath)
            {
                this._parentPath.splice(0, this._parentPath.length);
            }
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            var _loc_4:* = null;
            super.enterFrame(event);
            var _loc_2:* = getTimer();
            var _loc_3:* = this.state == Params.CUTE_PET_NORMAL ? (1000) : (200);
            if (_loc_2 - this._lastPickTime >= _loc_3)
            {
                this._lastPickTime = _loc_2;
                if (BackpackObj.getInstance().isFull() && !MapControl.getInstance().jugeElementIsPick())
                {
                    _loc_4 = Params.PICK_LIST_WITH_BAG_FULL;
                }
                MapControl.getInstance().dropTakeUpGoodsWithRange(x, y, 5 * MapUtils.GRID_BORDER, Params.DROP_CUTE_PET_PICK_LIMIT, false, _loc_4, true);
            }
            this.checkDisWithParent(_loc_2);
            return;
        }// end function

        override public function pathByCoo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = true, param7:Boolean = false, param8:Boolean = true) : Boolean
        {
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_9:* = MapUtils.coo2Tile(x);
            var _loc_10:* = MapUtils.coo2Tile(y);
            var _loc_11:* = MapUtils.coo2Tile(param1);
            var _loc_12:* = MapUtils.coo2Tile(param2);
            var _loc_13:* = MapUtils.findPath(MapObj.getInstance().tilesba, _loc_9, _loc_10, _loc_11, _loc_12, param3);
            if (MapUtils.findPath(MapObj.getInstance().tilesba, _loc_9, _loc_10, _loc_11, _loc_12, param3) && _loc_13.length)
            {
                _loc_14 = [];
                if (param3 == 0)
                {
                    _loc_15 = _loc_13.length - 2;
                    _loc_16 = 1;
                    while (_loc_16 < _loc_15)
                    {
                        
                        _loc_14.push(MapUtils.tile2Coo(_loc_13[_loc_16]));
                        _loc_16 = _loc_16 + 1;
                    }
                    _loc_14.push([param1, param2]);
                }
                else
                {
                    _loc_15 = _loc_13.length - 1;
                    _loc_16 = 1;
                    while (_loc_16 < _loc_15)
                    {
                        
                        _loc_14.push(MapUtils.tile2Coo(_loc_13[_loc_16]));
                        _loc_16 = _loc_16 + 1;
                    }
                }
                return pathByAStarArray(_loc_14);
            }
            return false;
        }// end function

        private function checkDisWithParent(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (_info && param1 - this._lastCheckTime >= 500)
            {
                this._lastCheckTime = param1;
                _loc_2 = RoleList.getInstance().getRole(CutePetInfo(_info).parentId);
                if (_loc_2)
                {
                    if (Math.abs(_loc_2._x - _x) > Params.CUTE_PET_WALK_MAX_RANGE || Math.abs(_loc_2._y - _y) > Params.CUTE_PET_WALK_MAX_RANGE)
                    {
                        this.flyToParent();
                    }
                    else
                    {
                        _loc_3 = Math.abs(x - _loc_2._x) > 200 || Math.abs(y - _loc_2._y) > 200;
                        if (this.state != Params.CUTE_PET_NORMAL && !isPathing)
                        {
                            this.state = Params.CUTE_PET_NORMAL;
                            this.flyToParent();
                        }
                        if (this.state == Params.CUTE_PET_NORMAL)
                        {
                            if (BackpackObj.getInstance().isFull() && !MapControl.getInstance().jugeElementIsPick())
                            {
                                _loc_4 = Params.PICK_LIST_WITH_BAG_FULL;
                            }
                            _loc_5 = MapControl.getInstance().dropTakeUpGoodsOutRange(x, y, 5 * MapUtils.GRID_BORDER, _loc_4, true);
                            if (_loc_5)
                            {
                                if (this.pathByCoo(_loc_5.x, _loc_5.y, 0))
                                {
                                    this.state = Params.CUTE_PET_MOVE_TO_DROP;
                                }
                                else
                                {
                                    MapControl.getInstance().dropTakeUpGoods(_loc_5);
                                    this.returnToParent();
                                }
                            }
                            else if (_loc_3 && this.state == Params.CUTE_PET_NORMAL)
                            {
                                this.backToParent();
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            TweenLite.killDelayedCallsTo(this.flyToParent);
            return;
        }// end function

    }
}
