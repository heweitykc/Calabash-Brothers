package com.game.role.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.path.*;
    import com.game.role.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class FlyCutePet extends SimpleRole implements ICutePet
    {
        private var _lastCheckTime:Number = 0;
        private var _lastAutoMoveTime:Number = 0;
        private var _targetX:Number = 0;
        private var _targetY:Number = 0;

        public function FlyCutePet()
        {
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            super.enterFrame(event);
            this.checkDisWithParent(getTimer());
            return;
        }// end function

        override protected function arrive() : void
        {
            this._lastAutoMoveTime = getTimer();
            this._targetX = 0;
            this._targetY = 0;
            super.arrive();
            return;
        }// end function

        public function moveToParent(param1:Array) : void
        {
            TweenLite.delayedCall(0.2, this.backToParent);
            return;
        }// end function

        public function flyToParent() : void
        {
            var _loc_1:* = null;
            if (!_info || !CutePetInfo(_info).parentId)
            {
                return;
            }
            _loc_1 = RoleList.getInstance().getRole(CutePetInfo(_info).parentId);
            if (_loc_1)
            {
                x = _loc_1._x + MapUtils.GRID_BORDER * (4 - Math.ceil(8 * Math.random()));
                y = _loc_1._y + MapUtils.GRID_BORDER * 5 * Math.random();
                this.arrive();
            }
            return;
        }// end function

        override public function set info(param1:RoleInfo) : void
        {
            super.info = param1;
            if (param1)
            {
                FrameworkGlobal.addMsgListen(GameEvent.SHOW_OR_HIDE_PLAYERS, this.showOrHidePlayers);
            }
            this.showOrHidePlayers();
            return;
        }// end function

        private function showOrHidePlayers(event:GameEvent = null) : void
        {
            var _loc_2:* = UICfg.hideOtherPlayer;
            if (_loc_2 && !this.isUserPet())
            {
                visible = false;
            }
            else
            {
                visible = true;
            }
            return;
        }// end function

        private function isUserPet() : Boolean
        {
            if (info && UserObj.getInstance().playerInfo)
            {
                return CutePetInfo(info).parentId.equal(UserObj.getInstance().playerInfo.personId);
            }
            return false;
        }// end function

        private function checkDisWithParent(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
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
                        _loc_3 = Math.abs(x - _loc_2._x) > 200 || Math.abs(y - _loc_2._y) > 200 || y > _loc_2._y;
                        if (_loc_3)
                        {
                            this.backToParent();
                        }
                    }
                }
            }
            if (_info && param1 - this._lastAutoMoveTime >= 3000)
            {
                this.backToParent();
            }
            return;
        }// end function

        private function backToParent() : void
        {
            TweenLite.killDelayedCallsTo(this.backToParent);
            if (!_info)
            {
                return;
            }
            var _loc_1:* = RoleList.getInstance().getRole(CutePetInfo(_info).parentId);
            if (!_loc_1)
            {
                return;
            }
            if (!isPathing || _loc_1._x != this._targetX || _loc_1._y != this._targetY)
            {
                this._targetX = _loc_1._x;
                this._targetY = _loc_1._y;
                pathByAStarArray([[_loc_1._x + MapUtils.GRID_BORDER * (4 - 8 * Math.random()), _loc_1._y - MapUtils.GRID_BORDER * (5 * Math.random() + 1)]]);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.killDelayedCallsTo(this.backToParent);
            super.finalize();
            return;
        }// end function

    }
}
