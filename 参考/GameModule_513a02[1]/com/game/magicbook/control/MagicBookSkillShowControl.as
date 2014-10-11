package com.game.magicbook.control
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.magicbook.bean.*;
    import com.game.magicbook.message.*;
    import com.game.magicbook.view.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class MagicBookSkillShowControl extends Object
    {
        private var _topLayer:BaseSprite;
        private var _bottomLayer:BaseSprite;
        private var _roleList:RoleList;
        private var _magicBookList:MagicBookRoleList;
        private static const ONE_SCENE_SKILL_EFFECT_NUM:uint = 3;
        private static var _instance:MagicBookSkillShowControl;

        public function MagicBookSkillShowControl()
        {
            this._roleList = RoleList.getInstance();
            this._magicBookList = MagicBookRoleList.getInstance();
            return;
        }// end function

        public function showSkillView(param1:ResMagicbookAttacklMessage) : void
        {
            var _loc_2:* = MagicBookSkillCfgObj.getInstance().getMagicSkillInfo(param1.skillId);
            _loc_2.targetRole = RoleList.getInstance().getRole(param1.targetId);
            this.checkAndAttack(RoleList.getInstance().getRole(param1.playerId), _loc_2);
            return;
        }// end function

        public function set currentGameScene(param1:GameScene) : void
        {
            this._topLayer = param1.topLayer;
            this._bottomLayer = param1.bottomLayer;
            return;
        }// end function

        public function attacked(param1:ResBeAttackInfoMessage) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_2:* = param1.beAttacks;
            var _loc_4:* = _loc_2.length;
            var _loc_6:* = RoleList.getInstance().getRole(param1.sourceId);
            if (!RoleList.getInstance().getRole(param1.sourceId))
            {
                return;
            }
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_3 = _loc_2[_loc_7];
                _loc_5 = RoleList.getInstance().getRole(_loc_3.targetId);
                if (!_loc_5)
                {
                    Log.log("魔法书主人不存在");
                }
                else
                {
                    _loc_8 = MapUtils.countDirection(_loc_6._x, _loc_6._y, _loc_5._x, _loc_5._y);
                    if (!_loc_5)
                    {
                    }
                    else
                    {
                        _loc_9 = 0;
                        if (_loc_3.result == -1)
                        {
                            this.showMiss(_loc_5);
                        }
                        else if (_loc_3.result == 0)
                        {
                            _loc_9 = 64;
                        }
                        (_loc_5 as Role).attacked(UserObj.getInstance().playerInfo.personId.equal(param1.sourceId), -_loc_3.hurt, _loc_9, 1, _loc_8);
                        if (_loc_3.currentHp <= 0)
                        {
                            if (!_loc_5.isPlayer())
                            {
                                _loc_5.kickFly(_loc_6, 300);
                                this._roleList.removeRole(_loc_5);
                            }
                            else
                            {
                                Log.log("被魔法书死");
                            }
                        }
                    }
                }
                _loc_7++;
            }
            return;
        }// end function

        private function showMiss(param1:IRole) : void
        {
            var _loc_2:* = null;
            if (param1.isMonster())
            {
                _loc_2 = ObjectPool.CheckOut(getDefinitionByName("fightMonsterMiss") as Class);
            }
            else
            {
                _loc_2 = ObjectPool.CheckOut(getDefinitionByName("fightPlayerMiss") as Class);
            }
            if (param1.isPlayer() && UICfg.hideOtherPlayer && !param1.isUser())
            {
            }
            else if ((param1.isMonster() || param1.isClientMonster()) && UICfg.NORMAL_MONSTER)
            {
            }
            else
            {
                param1.showTopCue(_loc_2, 0, 0, 0, 58, ScrollMC.MISS_TYPE, 1, 100, 0.5, true, 0, 0, 1, 22, 1);
            }
            return;
        }// end function

        public function checkAndAttack(param1:IRole, param2:MagicBookSkillInfo) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 && param1.alive())
            {
                _loc_3 = param1.info.personId;
                if (_loc_3)
                {
                    _loc_4 = this._magicBookList.getMagicBookRole(_loc_3);
                    this.showActAndStartRelease(_loc_4, param2);
                }
            }
            else
            {
                Log.log("MagicBookSkillShowControl::攻击不存在");
                return false;
            }
            return true;
        }// end function

        public function showActAndStartRelease(param1:IMagicBookRole, param2:MagicBookSkillInfo) : void
        {
            if (!param1 || !param1.info)
            {
                Log.log("MagicBookSkillShowControl::攻击者不存在，或者已经死亡");
                return;
            }
            (param1.info as MagicBookInfo).magicSkill = param2;
            param1.setAct(param2.actType, false, true, true);
            if (param1.isLoadingRes())
            {
                param1.addEvtListener(RoleEvent.ACT_RES_LOADED, this.__roleActLoadComplete);
            }
            else
            {
                this.roleActLoadComplete(param1, param2);
            }
            return;
        }// end function

        private function __roleActLoadComplete(event:RoleEvent) : void
        {
            var _loc_2:* = IMagicBookRole(event.currentTarget);
            _loc_2.removeEvtListener(RoleEvent.ACT_RES_LOADED, this.__roleActLoadComplete);
            this.roleActLoadComplete(_loc_2, (_loc_2.info as MagicBookInfo).magicSkill);
            return;
        }// end function

        private function roleActLoadComplete(param1:IMagicBookRole, param2:MagicBookSkillInfo) : void
        {
            if (!param1 || !param1.info)
            {
                return;
            }
            if (param2)
            {
                if (param2.flyURL)
                {
                    TweenLite.delayedCall(param1.currentActEffectTime, this.showFly, [param1, param2]);
                }
                if (param2.roundeffectURL)
                {
                    TweenLite.delayedCall(param1.currentActEffectTime, this.showRoundEffect, [param1, param2]);
                }
            }
            return;
        }// end function

        private function showRoundEffect(param1:IMagicBookRole, param2:MagicBookSkillInfo) : void
        {
            if (param1 && param1.info)
            {
                if (param2.roundeffectURL)
                {
                    VMCManager.addRes(param2.roundeffectURL, this.doShowRoundEffect, [param1, param2]);
                }
            }
            return;
        }// end function

        private function doShowRoundEffect(param1:IMagicBookRole, param2:MagicBookSkillInfo) : void
        {
            var _loc_3:* = null;
            if (param2.roundeffectURL)
            {
                _loc_3 = new VMCView();
                _loc_3.move(param1._x, param1._y);
                if (VMCManager.getPoseInfo(param2.roundeffectURL, "90"))
                {
                    _loc_3.url = param2.roundeffectURL;
                    _loc_3.auto = true;
                    _loc_3.updatePose(FrameworkGlobal.DIRECT_90.toString(), false, false, true, true);
                }
                if (Math.abs(param1.direct) < 90)
                {
                    this._bottomLayer.addChild(_loc_3);
                }
                else
                {
                    this._topLayer.addChild(_loc_3);
                }
            }
            return;
        }// end function

        private function showFly(param1:IMagicBookRole, param2:MagicBookSkillInfo, param3:Function = null) : void
        {
            if (param1 && param1.info)
            {
                if (param2.flyURL)
                {
                    VMCManager.addRes(param2.flyURL, this.doShowFly, [param1, param2, param3]);
                }
            }
            return;
        }// end function

        private function doShowFly(param1:IMagicBookRole, param2:MagicBookSkillInfo, param3:Function = null) : void
        {
            if (param2.flyURL)
            {
                this.flySkill(param2, param1);
            }
            return;
        }// end function

        private function flySkill(param1:MagicBookSkillInfo, param2:IMagicBookRole, param3:int = 0, param4:Function = null) : void
        {
            var _loc_9:* = NaN;
            var _loc_5:* = new VMCView();
            if (VMCManager.getPoseInfo(param1.flyURL, "90"))
            {
                _loc_5.url = param1.flyURL;
                _loc_5.auto = true;
                _loc_5.updatePose(FrameworkGlobal.DIRECT_90.toString(), true, false);
            }
            if (_loc_5.poseInfo.scale > 1)
            {
                _loc_5.scale = _loc_5.poseInfo.scale;
            }
            var _loc_6:* = new FlySkillContainer(param1);
            _loc_6.arrow = _loc_5;
            var _loc_7:* = this.countOffset(param2, -_loc_5.offsetX, _loc_5.offsetY);
            _loc_6.move(param2._x + _loc_7.x, param2._y + _loc_7.y);
            this._topLayer.addChild(_loc_6);
            var _loc_8:* = param1.targetRole;
            if (param1.targetRole)
            {
                _loc_9 = _loc_8.high * _loc_5.offsetY;
                if (_loc_9 > 100)
                {
                    _loc_9 = 100;
                }
            }
            if (_loc_8 && _loc_8 != param2)
            {
                _loc_6.fly(_loc_8._x, _loc_8._y - _loc_9, this.flyArrive, [_loc_5, param4], param3);
            }
            return;
        }// end function

        private function flyArrive(param1:VMCView, param2:Function) : void
        {
            param1.removeFromParent(true);
            if (param2 != null)
            {
                param2.call();
            }
            return;
        }// end function

        private function countOffset(param1:IMagicBookRole, param2:int, param3:Number) : Point
        {
            var _loc_5:* = 0;
            var _loc_4:* = (-param1.high) * param3 + param1.getHigh();
            _loc_5 = param2;
            return new Point(_loc_5, _loc_4);
        }// end function

        public static function getInstance() : MagicBookSkillShowControl
        {
            if (!_instance)
            {
                _instance = new MagicBookSkillShowControl;
            }
            return _instance;
        }// end function

    }
}
