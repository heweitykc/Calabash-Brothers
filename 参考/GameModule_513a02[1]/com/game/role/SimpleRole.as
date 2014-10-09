package com.game.role
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.map.control.*;
    import com.game.structs.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class SimpleRole extends RoleView implements ISimpleRole
    {
        protected var _isPathing:Boolean;
        private var _interval:uint = 0;
        public var target:Array;
        private var _changeToDir:int;
        private var dirs:Array;
        public var path:Array;
        private var destinationPX:uint;
        private var destinationPY:uint;
        private var stPosition:Array;
        private var stTime:uint;
        private var spaceTime:uint;
        private var distanceTime:uint;
        private var distanceX:Number;
        private var distanceY:Number;
        private var lastTime:uint;
        private var lastSynPathTime:uint;
        private var _curPathStep:uint;

        public function SimpleRole()
        {
            return;
        }// end function

        override public function set info(param1:RoleInfo) : void
        {
            super.info = param1;
            _info.addEvtListener(RoleEvent.UPDATE_SPEED, this.__speedChange);
            return;
        }// end function

        public function get isPathing() : Boolean
        {
            return this._isPathing;
        }// end function

        public function pathByAStarArray(param1:Array, param2:Array = null) : Boolean
        {
            if (!param1 || param1.length == 0)
            {
                this.arrive();
                return true;
            }
            if (_fatherActType != Params.ACTION_RUN)
            {
                setAct(Params.ACTION_RUN, true, false);
            }
            this.dirs = param2;
            this.path = param1;
            this._isPathing = true;
            this.setToNextTarget();
            return true;
        }// end function

        private function checkState() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in _info.buffs)
            {
                
                if (_loc_1.q_action_type == BuffType.STAKME)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function pathByCoo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = true, param7:Boolean = false, param8:Boolean = true) : Boolean
        {
            var _loc_12:* = null;
            if (!this.checkState())
            {
                return false;
            }
            var _loc_9:* = Math.sqrt((param1 - _x) * (param1 - _x) + (param2 - _y) * (param2 - _y));
            if (Math.sqrt((param1 - _x) * (param1 - _x) + (param2 - _y) * (param2 - _y)) <= (param3 + 1) * MapUtils.GRID_BORDER)
            {
                Log.log("已经在范围内了 , 已经到达了！");
                this.arrive();
                return true;
            }
            if (MapUtils.coo2Tile(param1) == MapUtils.coo2Tile(_x) && MapUtils.coo2Tile(param2) == MapUtils.coo2Tile(_y))
            {
                Log.log("pathByCoo，要跑的位置跟现在位置一样，不用跑了");
                this.arrive();
                return true;
            }
            if (this._isPathing)
            {
                if (this.destinationPX == MapUtils.coo2Tile(param1) && this.destinationPY == MapUtils.coo2Tile(param2))
                {
                    Log.log("pathByCoo，正在朝这个位置跑呢");
                    return true;
                }
            }
            var _loc_10:* = PlayerCfgObj.getInstance().checkAct(Params.ACTION_RUN, _fatherActType, isEffect(), isUser());
            if (PlayerCfgObj.getInstance().checkAct(Params.ACTION_RUN, _fatherActType, isEffect(), isUser()) == PlayerCfgObj.ACT_IGNORE)
            {
                return false;
            }
            var _loc_11:* = MapControl.getInstance().findPath(_x, _y, param1, param2, param3, param8);
            if (MapControl.getInstance().findPath(_x, _y, param1, param2, param3, param8) && _loc_11.length == 2)
            {
                _loc_12 = _loc_11[0];
                if (_loc_12 != null && _loc_12.length > 0)
                {
                    this.destinationPX = MapUtils.coo2Tile(param1);
                    this.destinationPY = MapUtils.coo2Tile(param2);
                    this.pathByAStarArray(_loc_12, _loc_11[1]);
                    return true;
                }
            }
            return false;
        }// end function

        override public function updatePosition() : void
        {
            move(_info.x, _info.y);
            this.checkAlpha();
            return;
        }// end function

        public function stopByPosition(param1:Position, param2:Function = null, param3:Array = null) : void
        {
            if (param1.x != x && param1.y != y)
            {
                Log.log("被拉了", x, y, "---", param1.x, param1.y);
            }
            this.stopPath();
            move(param1.x, param1.y);
            if (info)
            {
                info.x = param1.x;
                info.y = param1.y;
            }
            return;
        }// end function

        public function flyByPosition(param1:Position, param2:Number = 0, param3:Function = null, param4:Array = null, param5:Boolean = true) : void
        {
            this.stopPath();
            this.move2(param1.x, param1.y, param2, param3, param4, param5);
            return;
        }// end function

        public function move2(param1:Number, param2:Number, param3:Number = 1, param4:Function = null, param5:Array = null, param6:Boolean = false, param7:uint = 1) : void
        {
            this._isPathing = true;
            if (isUser())
            {
                Player.actState = State.DRAG;
            }
            TweenLite.killTweensOf(this, false);
            if (param6)
            {
                TweenLite.to(this, param3, {x:param1, y:param2, onUpdate:this.projective, onUpdateParams:[param7], onComplete:this.move2Complete, onCompleteParams:[param4, param5], ease:Linear.easeNone});
            }
            else
            {
                TweenLite.to(this, param3, {x:param1, y:param2, onComplete:this.move2Complete, onCompleteParams:[param4, param5], ease:Linear.easeNone});
            }
            return;
        }// end function

        private function projective(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (this.parent)
            {
                var _loc_4:* = this;
                var _loc_5:* = this._interval + 1;
                _loc_4._interval = _loc_5;
                if (this._interval > param1)
                {
                    this._interval = 0;
                    _loc_2 = new Bitmap();
                    _loc_2.bitmapData = this.bmp.bitmapData;
                    _loc_3 = this.bmp.poseProgress;
                    this.parent.addChild(_loc_2);
                    _loc_2.alpha = 0.9;
                    _loc_2.scaleX = direct > 0 ? (1) : (-1);
                    if (bmp.offsets != null)
                    {
                        _loc_2.x = x + this.bmp.offsets[_loc_3][0] * _loc_2.scaleX;
                        _loc_2.y = y + this.bmp.offsets[_loc_3][1];
                    }
                    TweenLite.to(_loc_2, 0.5, {alpha:0, onComplete:this.removeBt, onCompleteParams:[_loc_2], ease:Linear.easeNone});
                }
            }
            return;
        }// end function

        private function removeBt(param1:Bitmap) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        private function move2Complete(param1:Function, param2:Array) : void
        {
            this._isPathing = false;
            if (isUser())
            {
                Player.actState = State.NONE;
            }
            if (param1 != null)
            {
                if (param2 == null)
                {
                    param1.apply(null);
                }
                else
                {
                    param1.apply(null, param2);
                }
            }
            return;
        }// end function

        protected function arrive() : void
        {
            this.dirs = null;
            this.path = null;
            this._isPathing = false;
            this._curPathStep = 0;
            setAct(Params.ACTION_STAND_ID, true, false);
            dispatchEvent(new RoleEvent(RoleEvent.ARRIVE));
            return;
        }// end function

        protected function setToNextTarget() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.path && this.path.length > 0)
            {
                this.target = this.path.shift() as Array;
                if (this.dirs && this.dirs.length > 0)
                {
                    this._changeToDir = this.dirs.shift();
                }
                if (isUser() && MapControl.coordFrom.x && MapControl.coordFrom.y && MapControl.coordTo.x && MapControl.coordTo.y && MapControl.coordArr && MapControl.coordArr.length)
                {
                    _loc_1 = MapUtils.coo2Tile(_x);
                    _loc_2 = MapUtils.coo2Tile(_y);
                    _loc_3 = [MapUtils.coo2Tile(this.target[0]), MapUtils.coo2Tile(this.target[1])];
                }
                dispatchEvent(new RoleEvent(RoleEvent.PATHING_POINT_UPDATE));
                this.setToTarget(this.target);
            }
            else
            {
                this.target = null;
                this.stPosition = null;
                this.stTime = 0;
                this.distanceTime = 0;
                this.distanceX = 0;
                this.distanceY = 0;
                this.arrive();
            }
            return;
        }// end function

        private function pathDirectChange(param1:Array) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.dirs && this.dirs.length > 0)
            {
                if ((this._changeToDir == 0 || this._changeToDir == 2 || this._changeToDir == 4 || this._changeToDir == 6) && this.dirs.length > 0 && this.dirs[0] == MapUtils.roleDir2MapDirect(direct))
                {
                    return;
                }
                _loc_3 = MapUtils.mapDirect2RoleDir(this._changeToDir);
            }
            else
            {
                _loc_2 = ToolKit.getAngle(_x, _y, param1[0], param1[1]);
                if (_loc_2 > 337 || _loc_2 < 23)
                {
                    _loc_3 = FrameworkGlobal.DIRECT_90;
                }
                else if (_loc_2 > 292)
                {
                    _loc_3 = FrameworkGlobal.DIRECT_45;
                }
                else if (_loc_2 > 247)
                {
                    _loc_3 = FrameworkGlobal.DIRECT_0;
                }
                else if (_loc_2 > 202)
                {
                    _loc_3 = -FrameworkGlobal.DIRECT_45;
                }
                else if (_loc_2 > 157)
                {
                    _loc_3 = -FrameworkGlobal.DIRECT_90;
                }
                else if (_loc_2 > 112)
                {
                    _loc_3 = -FrameworkGlobal.DIRECT_135;
                }
                else if (_loc_2 > 67)
                {
                    _loc_3 = FrameworkGlobal.DIRECT_180;
                }
                else
                {
                    _loc_3 = FrameworkGlobal.DIRECT_135;
                }
            }
            if (direct != _loc_3)
            {
                direct = _loc_3;
            }
            return;
        }// end function

        private function setToTarget(param1:Array) : void
        {
            if (!param1)
            {
                return;
            }
            if (!_info)
            {
                return;
            }
            this.pathDirectChange(param1);
            this.lastTime = getTimer();
            this.stPosition = [_x, _y];
            this.stTime = getTimer() - this.spaceTime;
            this.distanceTime = ToolKit.distance(_x, _y, param1[0], param1[1]) * 1000 / _info.speed;
            this.distanceX = param1[0] - _x;
            this.distanceY = param1[1] - _y;
            if (this.spaceTime > 0)
            {
                this.pathingUpdate();
            }
            return;
        }// end function

        public function stopPath() : void
        {
            if (this._isPathing)
            {
                this.target = null;
                this.stPosition = null;
                this.stTime = 0;
                this.distanceTime = 0;
                this.distanceX = 0;
                this.distanceY = 0;
                this._curPathStep = 0;
                this.path = null;
                this._isPathing = false;
                if (actType != Params.ACTION_STAND_ID)
                {
                    setAct(Params.ACTION_STAND_ID, true, false, true);
                }
                if (isUser())
                {
                    Player.actState = State.NONE;
                }
                TweenLite.killTweensOf(this, false);
            }
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            super.enterFrame(event);
            this.pathingUpdate();
            return;
        }// end function

        private function pathingUpdate() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            if (this._isPathing)
            {
                _loc_1 = getTimer();
                if (this.target)
                {
                    _loc_2 = _loc_1 - this.stTime;
                    _loc_3 = this.distanceTime - _loc_2;
                    if (_loc_3 > 0)
                    {
                        _loc_4 = (_loc_1 - this.stTime) / this.distanceTime;
                        move(this.stPosition[0] + this.distanceX * _loc_4, this.stPosition[1] + this.distanceY * _loc_4);
                        if (_loc_1 - this.lastSynPathTime > 200)
                        {
                            this.lastSynPathTime = _loc_1;
                            dispatchEvent(new RoleEvent(RoleEvent.PATHING_UPDATE));
                        }
                    }
                    else
                    {
                        move(this.target[0], this.target[1]);
                        this.spaceTime = -_loc_3;
                        this.setToNextTarget();
                    }
                    this.checkAlpha();
                }
                this.lastTime = _loc_1;
            }
            return;
        }// end function

        public function checkAlpha() : void
        {
            if (MapControl.getInstance().isAlpha(px, py))
            {
                if (_bodyView)
                {
                    if (_bodyView.alpha == 1)
                    {
                        _bodyView.alpha = 0.5;
                    }
                }
                if (_weaponView)
                {
                    if (_weaponView.alpha == 1)
                    {
                        _weaponView.alpha = 0.5;
                    }
                }
                if (_otherWeaponView)
                {
                    if (_otherWeaponView.alpha == 1)
                    {
                        _otherWeaponView.alpha = 0.5;
                    }
                }
                if (_wingView)
                {
                    if (_wingView.alpha == 1)
                    {
                        _wingView.alpha = 0.5;
                    }
                }
                if (_horseView)
                {
                    if (_horseView.alpha == 1)
                    {
                        _horseView.alpha = 0.5;
                    }
                }
                if (_horseWingView)
                {
                    if (_horseWingView.alpha == 1)
                    {
                        _horseWingView.alpha = 0.5;
                    }
                }
            }
            else
            {
                if (_bodyView)
                {
                    if (_bodyView.alpha < 1)
                    {
                        _bodyView.alpha = 1;
                    }
                }
                if (_weaponView)
                {
                    if (_weaponView.alpha < 1)
                    {
                        _weaponView.alpha = 1;
                    }
                }
                if (_horseView)
                {
                    if (_horseView.alpha < 1)
                    {
                        _horseView.alpha = 1;
                    }
                }
                if (_otherWeaponView)
                {
                    if (_otherWeaponView.alpha < 1)
                    {
                        _otherWeaponView.alpha = 1;
                    }
                }
                if (_wingView)
                {
                    if (_wingView.alpha < 1)
                    {
                        _wingView.alpha = 1;
                    }
                }
                if (_horseWingView)
                {
                    if (_horseWingView.alpha < 1)
                    {
                        _horseWingView.alpha = 1;
                    }
                }
            }
            return;
        }// end function

        private function __speedChange(event:Event) : void
        {
            this.setToTarget(this.target);
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.killTweensOf(this, false);
            this.stopPath();
            super.finalize();
            return;
        }// end function

        public function manyou() : void
        {
            addEvtListener(RoleEvent.ARRIVE, this.manyouDao);
            this.manyouDao(null);
            return;
        }// end function

        private function manyouDao(event:Event) : void
        {
            this.pathByCoo(Math.random() * 1000, Math.random() * 600);
            return;
        }// end function

    }
}
