package com.game.role
{
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.events.*;
    import interfaces.role.*;

    public class MagicBookRole extends SimpleRole implements IMagicBookRole
    {
        private var _lastCheckTime:Number = 0;
        private var _lastAutoMoveTime:Number = 0;
        private var _targetX:Number = 0;
        private var _targetY:Number = 0;
        private var _parentRole:IRole;
        private var offsetRoleX:Number = -70;
        private var offsetRoleY:Number = -50;
        private var moveSpeed:Number = 0;
        private var _bodyHigh:Number = -20;
        private var _interCall:int = 0;

        public function MagicBookRole()
        {
            this.unShine();
            var _loc_1:* = false;
            this.mouseChildren = false;
            this.mouseEnabled = _loc_1;
            _bodyView.move(0, this._bodyHigh);
            return;
        }// end function

        public function getHigh() : Number
        {
            return this._bodyHigh;
        }// end function

        public function moveToParent(param1:Array) : void
        {
            return;
        }// end function

        public function flyToParent() : void
        {
            return;
        }// end function

        public function moveTo(param1:IRole) : void
        {
            this._parentRole = param1;
            this._x = this._parentRole._x + this.offsetRoleX;
            this._y = this._parentRole._y + this.offsetRoleY;
            this.moveSpeed = 0;
            return;
        }// end function

        public function set player(param1:IRole) : void
        {
            this._parentRole = param1;
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            var _loc_2:* = 0;
            super.enterFrame(event);
            if (this._parentRole)
            {
                this.direct = this._parentRole.direct;
                _loc_2 = ToolKit.distance(this._x, this._y, this._parentRole._x, this._parentRole._y);
                if (_loc_2 > 80)
                {
                    var _loc_3:* = (this._parentRole._x - this._x) / 40 + this._x;
                    this._x = (this._parentRole._x - this._x) / 40 + this._x;
                    info.x = _loc_3;
                    var _loc_3:* = (this._parentRole._y - this._y) / 40 + this._y;
                    this._y = (this._parentRole._y - this._y) / 40 + this._y;
                    info.y = _loc_3;
                }
                if (this._interCall > 4)
                {
                    this._interCall = 0;
                    this.checkAlpha();
                }
                else
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this._interCall + 1;
                    _loc_3._interCall = _loc_4;
                }
            }
            return;
        }// end function

        override public function setAct(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false) : Boolean
        {
            var _loc_5:* = null;
            return super.setAct(param1, param2, param3, param4);
        }// end function

        override protected function makeShadow() : void
        {
            super.makeShadow();
            if (_shadowMC)
            {
                var _loc_1:* = 0.6;
                _shadowMC.scaleY = 0.6;
                _shadowMC.scaleX = _loc_1;
                _shadowMC.alpha = _loc_1;
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

        override public function finalize() : void
        {
            FrameworkGlobal.removeMsgListen(GameEvent.SHOW_OR_HIDE_PLAYERS, this.showOrHidePlayers);
            super.finalize();
            return;
        }// end function

        override public function checkAlpha() : void
        {
            if (MapControl.getInstance().isAlpha(px, py - 2))
            {
                if (_bodyView)
                {
                    if (_bodyView.alpha == 1)
                    {
                        _bodyView.alpha = 0.5;
                    }
                }
            }
            else if (_bodyView)
            {
                if (_bodyView.alpha < 1)
                {
                    _bodyView.alpha = 1;
                }
            }
            return;
        }// end function

        private function showOrHidePlayers(event:GameEvent = null) : void
        {
            var _loc_2:* = UICfg.hideOtherPlayer;
            if (_loc_2 && !this.isUserMagicBook())
            {
                visible = false;
            }
            else
            {
                visible = true;
            }
            return;
        }// end function

        private function isUserMagicBook() : Boolean
        {
            if (info && UserObj.getInstance().playerInfo)
            {
                return MagicBookInfo(info).parentId.equal(UserObj.getInstance().playerInfo.personId);
            }
            return false;
        }// end function

    }
}
