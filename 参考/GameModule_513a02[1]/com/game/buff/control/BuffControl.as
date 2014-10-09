package com.game.buff.control
{
    import com.*;
    import com.events.*;
    import com.game.buff.message.*;
    import com.game.buff.protocol.*;
    import com.game.primaryrole.control.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import interfaces.role.*;

    public class BuffControl extends Object
    {
        private var _protocol:BuffProtocol;
        private var _frozen:int = 0;
        private var _lockSkill:int;
        private var _restrictSkill:int = 0;
        private var _restrictMove:int = 0;
        private var _hasLowLimitBuff:Boolean = false;
        public static const BLACKOUT:int = 3;
        public static const FROZEN:int = 4;
        public static const LOCK_SKILL:int = 5;
        private static var instance:BuffControl;

        public function BuffControl()
        {
            this._protocol = new BuffProtocol();
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
            return;
        }// end function

        public function get hasLowLimitBuff() : Boolean
        {
            return this._hasLowLimitBuff;
        }// end function

        public function get frozen() : int
        {
            return this._frozen;
        }// end function

        public function get lockSKill() : int
        {
            return this._lockSkill;
        }// end function

        public function get restrictSkill() : Boolean
        {
            return this._restrictSkill > 0;
        }// end function

        public function get restrictMove() : Boolean
        {
            return this._restrictMove > 0;
        }// end function

        public function removeBuff(param1:long) : void
        {
            this._protocol.reqRemoveBuff(param1);
            return;
        }// end function

        public function getBuffInfo(param1:long) : void
        {
            this._protocol.reqBuffInfo(param1);
            return;
        }// end function

        private function __updateBuff(event:RoleEvent) : void
        {
            if (event.obj.t == BuffSpecilId.LOW_LIMIT)
            {
                this._hasLowLimitBuff = true;
                PrimaryRoleControl.getInstance().updateMagicAtkLow();
            }
            return;
        }// end function

        public function buffsHandler(param1:ResBuffsMessage) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo;
            _loc_2.initBuffs(param1.buff);
            return;
        }// end function

        public function buffInfoHandler(param1:ResBuffInfoMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            if (_loc_2)
            {
                _loc_2.getBuffInfoBack(param1);
            }
            return;
        }// end function

        public function addBuffHandler(param1:ResAddBuffMessage) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2 && _loc_2.info)
            {
                _loc_3 = _loc_2.info.addBuff(param1.buff);
                if (!_loc_3)
                {
                    return;
                }
                _loc_2.addBuffView(_loc_3);
                if (_loc_2.info && _loc_2.info.isPlayer(UserObj.getInstance().playerInfo.personId))
                {
                    if (_loc_3.q_category == BLACKOUT)
                    {
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictSkill + 1;
                        _loc_4._restrictSkill = _loc_5;
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictMove + 1;
                        _loc_4._restrictMove = _loc_5;
                    }
                    if (_loc_3.q_category == FROZEN)
                    {
                        var _loc_4:* = this;
                        var _loc_5:* = this._frozen + 1;
                        _loc_4._frozen = _loc_5;
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictMove + 1;
                        _loc_4._restrictMove = _loc_5;
                    }
                    if (_loc_3.q_category == LOCK_SKILL)
                    {
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictSkill + 1;
                        _loc_4._restrictSkill = _loc_5;
                        var _loc_4:* = this;
                        var _loc_5:* = this._lockSkill + 1;
                        _loc_4._lockSkill = _loc_5;
                    }
                }
                if (_loc_3.q_action_type == BuffType.SPEED)
                {
                    _loc_2.info.speed = _loc_2.info.speed + _loc_3.q_effect_value;
                }
                else if (_loc_3.q_action_type == BuffType.POISON)
                {
                }
                if (_loc_3.q_action_type == BuffType.STAKME)
                {
                    if (_loc_2.isUser())
                    {
                        Player.actState = State.STAKME;
                    }
                }
                if (_loc_3.q_buff_id == BuffSpecilId.BECOME1 || _loc_3.q_buff_id == BuffSpecilId.BECOME2 || _loc_3.q_buff_id == BuffSpecilId.BECOME3 || _loc_3.q_buff_id == BuffSpecilId.BECOME4)
                {
                    _loc_2.info.isBecome = true;
                }
                if (_loc_2.isUser())
                {
                    this.showPrompt(_loc_3);
                }
            }
            return;
        }// end function

        public function showPrompt(param1:BuffInfo) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = param1.getEffectPrompt();
            if (BuffSpecilId.PROMP_LIST.indexOf(param1.q_buff_id) > -1)
            {
                _loc_3 = _loc_2.indexOf(">");
                _loc_4 = _loc_2.lastIndexOf("<");
                _loc_5 = _loc_2.slice((_loc_3 + 1), _loc_4);
                _loc_6 = int(_loc_5) * param1.overlay;
                _loc_2 = _loc_2.replace(_loc_5, _loc_6.toString());
            }
            if (param1.q_buff_id == BuffSpecilId.LOW_LIMIT)
            {
                this._hasLowLimitBuff = true;
                PrimaryRoleControl.getInstance().updateMagicAtkLow();
            }
            if (_loc_2 == null || _loc_2 == "")
            {
            }
            else
            {
                Global.popManager.addedToFight(_loc_2);
            }
            return;
        }// end function

        public function removeBuffHandler(param1:ResRemoveBuffMessage) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2 && _loc_2.info)
            {
                _loc_3 = _loc_2.info.removeBuff(param1.buffId);
                if (!_loc_3)
                {
                    return;
                }
                if (_loc_3.num == 0)
                {
                    _loc_2.removeBuffView(_loc_3);
                }
                if (_loc_2.info && _loc_2.info.isPlayer(UserObj.getInstance().playerInfo.personId))
                {
                    if (_loc_3.q_category == BLACKOUT)
                    {
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictSkill - 1;
                        _loc_4._restrictSkill = _loc_5;
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictMove - 1;
                        _loc_4._restrictMove = _loc_5;
                    }
                    if (_loc_3.q_category == FROZEN)
                    {
                        var _loc_4:* = this;
                        var _loc_5:* = this._frozen - 1;
                        _loc_4._frozen = _loc_5;
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictMove - 1;
                        _loc_4._restrictMove = _loc_5;
                    }
                    if (_loc_3.q_category == LOCK_SKILL)
                    {
                        var _loc_4:* = this;
                        var _loc_5:* = this._restrictSkill - 1;
                        _loc_4._restrictSkill = _loc_5;
                        var _loc_4:* = this;
                        var _loc_5:* = this._lockSkill - 1;
                        _loc_4._lockSkill = _loc_5;
                    }
                }
                if (_loc_3.q_buff_id == BuffSpecilId.BING)
                {
                    _loc_2.info.speed = _loc_2.info.speed - _loc_3.q_effect_value;
                }
                else if (_loc_3.q_buff_id == BuffSpecilId.DU)
                {
                }
                else if (_loc_3.q_action_type == BuffType.STAKME)
                {
                    if (_loc_2.isUser())
                    {
                        Player.actState = State.NONE;
                    }
                }
                else if (_loc_3.q_buff_id == BuffSpecilId.LOW_LIMIT)
                {
                    if (_loc_2.isUser())
                    {
                        this._hasLowLimitBuff = false;
                        PrimaryRoleControl.getInstance().updateMagicAtkLow();
                    }
                }
                if (_loc_3.q_buff_id == BuffSpecilId.BECOME1 || _loc_3.q_buff_id == BuffSpecilId.BECOME2 || _loc_3.q_buff_id == BuffSpecilId.BECOME3 || _loc_3.q_buff_id == BuffSpecilId.BECOME4)
                {
                    _loc_2.info.isBecome = false;
                }
            }
            return;
        }// end function

        public function changeBuffHandler(param1:ResChangeBuffMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2 && _loc_2.info)
            {
                _loc_2.info.updateBuff(param1.buff);
            }
            return;
        }// end function

        public static function getInstance() : BuffControl
        {
            if (instance == null)
            {
                instance = new BuffControl;
            }
            return instance;
        }// end function

    }
}
