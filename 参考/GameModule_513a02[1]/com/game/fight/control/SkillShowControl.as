package com.game.fight.control
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.fight.view.*;
    import com.game.map.bean.*;
    import com.game.map.control.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.game.sound.control.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.fightbase.view.*;
    import flash.display.*;
    import flash.geom.*;
    import interfaces.role.*;

    public class SkillShowControl extends Object
    {
        public var currentSkillEffectNum:int;
        private var _topLayer:BaseSprite;
        private var _bottomLayer:BaseSprite;
        private var vecSkillFireSword:Vector.<SkillFireSwordView>;
        private var vecSkillBrainStorm:Vector.<SkillBrainStormView>;
        public static const ONE_SCENE_SKILL_EFFECT_NUM:uint = 3;

        public function SkillShowControl()
        {
            this.vecSkillFireSword = new Vector.<SkillFireSwordView>;
            this.vecSkillBrainStorm = new Vector.<SkillBrainStormView>;
            return;
        }// end function

        public function set currentGameScene(param1:GameScene) : void
        {
            this._topLayer = param1.topLayer;
            this._bottomLayer = param1.bottomLayer;
            return;
        }// end function

        public function showRelease(param1:IRole, param2:SkillInfo) : void
        {
            if (param1.isLoadingRes())
            {
                param1.setAttr("skillInfo", param2);
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
            var _loc_2:* = IRole(event.currentTarget);
            _loc_2.removeEvtListener(RoleEvent.ACT_RES_LOADED, this.__roleActLoadComplete);
            this.roleActLoadComplete(_loc_2, _loc_2.getAttr("skillInfo"));
            return;
        }// end function

        private function roleActLoadComplete(param1:IRole, param2:SkillInfo) : void
        {
            if (!param1 || !param1.info)
            {
                return;
            }
            if (param2)
            {
                if (param2.releaseURL || param2.releaseGroundURL)
                {
                    param2.direct = param1.direct;
                    TweenLite.delayedCall(param1.currentActReleaseTime, this.startShowRelease, [param1, param2]);
                }
                TweenLite.delayedCall(param1.currentActEffectTime, this.showFly, [param1, param2]);
            }
            return;
        }// end function

        private function playsound(param1:IRole, param2:SkillInfo) : void
        {
            SoundControl.getInstance().playSkillSound(param2.q_use_sound, SoundFlag.SKILL_USE);
            return;
        }// end function

        private function startShowRelease(param1:IRole, param2:SkillInfo) : void
        {
            if (param2.releaseURL)
            {
                if (!this.checkSkillShowNum(param1))
                {
                    return;
                }
                VMCManager.addRes(param2.releaseURL, this.doShowRelease, [param2.releaseURL, param1, param2, false]);
            }
            if (param2.releaseGroundURL)
            {
                if (!this.checkSkillShowNum(param1))
                {
                    return;
                }
                VMCManager.addRes(param2.releaseGroundURL, this.doShowRelease, [param2.releaseGroundURL, param1, param2, true]);
            }
            return;
        }// end function

        private function doShowRelease(param1:String, param2:IRole, param3:SkillInfo, param4:Boolean) : void
        {
            if (VMCManager.getPoseInfo(param1, FrameworkGlobal.DIRECT_90.toString()))
            {
                this.showReleaseView(param1, "", param2, param3, param4);
            }
            else
            {
                if (VMCManager.getPoseInfo(param1, "front_" + FrameworkGlobal.DIRECT_90.toString()))
                {
                    this.showReleaseView(param1, "front_", param2, param3, param4);
                }
                if (VMCManager.getPoseInfo(param1, "back_" + FrameworkGlobal.DIRECT_90.toString()))
                {
                    this.showReleaseView(param1, "back_", param2, param3, param4);
                }
            }
            return;
        }// end function

        private function showReleaseView(param1:String, param2:String, param3:IRole, param4:SkillInfo, param5:Boolean) : void
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (!param3 || !param3.info)
            {
                return;
            }
            _loc_6 = new VMCView();
            _loc_6.auto = true;
            _loc_6.direct = param3.direct;
            _loc_6.url = param1;
            if (!_loc_6.updatePose(param2 + Math.abs(_loc_6.direct).toString(), false, false, true, true))
            {
                _loc_6.updatePose(param2 + FrameworkGlobal.DIRECT_90.toString(), false, false, true, true);
            }
            if (_loc_6.poseInfo.scale > 1)
            {
                _loc_6.scale = _loc_6.poseInfo.scale;
            }
            if (param5)
            {
                if (_loc_6.rotate360)
                {
                    _loc_6.direct = 90;
                    _loc_7 = new Sprite();
                    _loc_6._x = -_loc_6.offsetX;
                    _loc_7.addChild(_loc_6);
                    _loc_8 = ToolKit.getAngle(param3._x, param3._y, param4.targetX, param4.targetY);
                    _loc_7.rotation = _loc_8;
                    _loc_7.x = param3._x;
                    _loc_7.y = param3._y - param3.high * _loc_6.offsetY;
                    _loc_6 = _loc_7;
                }
                else
                {
                    _loc_6.move(param3._x, param3._y - param3.high * _loc_6.offsetY);
                }
                if (param2 == "back_" || Math.abs(param3.direct) < 90)
                {
                    this._bottomLayer.addChild(_loc_6);
                }
                else
                {
                    this._topLayer.addChild(_loc_6);
                }
            }
            else
            {
                if (_loc_6.rotate360)
                {
                    _loc_6.direct = 90;
                    _loc_7 = new Sprite();
                    _loc_6._x = -_loc_6.offsetX + (param3 as Role).width / 8;
                    _loc_7.addChild(_loc_6);
                    _loc_8 = ToolKit.getAngle(param3._x, param3._y, param4.targetX, param4.targetY);
                    _loc_7.rotation = _loc_8;
                    _loc_7.x = 0;
                    _loc_7.y = (-param3.high) * _loc_6.offsetY;
                    _loc_6 = _loc_7;
                }
                else
                {
                    _loc_6.move(0, (-param3.high) * _loc_6.offsetY);
                }
                if (param2 == "back_" || Math.abs(param3.direct) < 90)
                {
                    param3.getSprite().addChildAt(_loc_6, 0);
                }
                else
                {
                    param3.getSprite().addChild(_loc_6);
                }
            }
            return;
        }// end function

        private function checkSkillShowNum(param1:IRole) : Boolean
        {
            if (MapControl.getInstance().getScreenShiledSelectState())
            {
                return false;
            }
            if (!param1.isUser())
            {
                if (!param1.isShow)
                {
                    return false;
                }
                if (this.currentSkillEffectNum >= ONE_SCENE_SKILL_EFFECT_NUM)
                {
                    return false;
                }
                var _loc_2:* = this;
                var _loc_3:* = this.currentSkillEffectNum + 1;
                _loc_2.currentSkillEffectNum = _loc_3;
                TweenLite.delayedCall(1.5, this.__playComplete);
            }
            return true;
        }// end function

        public function showFly(param1:IRole, param2:SkillInfo, param3:Function = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this.playsound(param1, param2);
            if (param1 && param1.info)
            {
                if (param2.flyURL)
                {
                    if (!this.checkSkillShowNum(param1) && param3 == null)
                    {
                        return;
                    }
                    if (param2.q_trajectory_effect == "archer")
                    {
                        _loc_4 = 1;
                        if (param1.info.weapon)
                        {
                            _loc_4 = param1.info.weapon.q_id;
                        }
                        _loc_5 = ArcherFlyeffectCfgObj.getInstance().getArcherFlyeffectByWeaponId(_loc_4);
                        param2.flyURL = Params.SKILL_PATH + _loc_5.q_trajectory_effect + ".png";
                    }
                    VMCManager.addRes(param2.flyURL, this.doShowFly, [param1, param2, param3]);
                }
                else if (param2.hitGroundURL)
                {
                    if (!this.checkSkillShowNum(param1))
                    {
                        return;
                    }
                    VMCManager.addRes(param2.hitGroundURL, this.doShowHit, [param2.hitGroundURL, param1, param2.targetRole, param2, true]);
                }
            }
            return;
        }// end function

        private function doShowFly(param1:IRole, param2:SkillInfo, param3:Function = null) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param2.q_trajectory_effect_dir)
            {
                _loc_4 = param2.q_trajectory_effect_dir.split("|");
                _loc_5 = _loc_4.length;
                _loc_6 = param2.q_trajectory_effect_time / 1000;
                _loc_8 = 0;
                while (_loc_8 < _loc_5)
                {
                    
                    _loc_7 = _loc_4[_loc_8];
                    TweenLite.delayedCall(_loc_6 * _loc_8, this.flySkill, [param2, param1, _loc_7, param3]);
                    _loc_8 = _loc_8 + 1;
                }
            }
            return;
        }// end function

        private function countOffset(param1:IRole, param2:int, param3:Number) : Point
        {
            var _loc_5:* = 0;
            var _loc_4:* = (-param1.high) * param3;
            _loc_5 = param2;
            return new Point(_loc_5, _loc_4);
        }// end function

        private function flySkill(param1:SkillInfo, param2:IRole, param3:int = 0, param4:Function = null) : void
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_5:* = new VMCView();
            if (VMCManager.getPoseInfo(param1.flyURL, "90"))
            {
                _loc_5.url = param1.flyURL;
                _loc_5.auto = true;
                _loc_5.updatePose(FrameworkGlobal.DIRECT_90.toString(), true, false);
            }
            else if (VMCManager.getPoseInfo(param1.flyURL, "front_90"))
            {
                _loc_5.url = param1.flyURL;
                _loc_5.auto = true;
                _loc_5.updatePose("front_90", true, false);
            }
            else
            {
                return;
            }
            if (_loc_5.poseInfo.scale > 1)
            {
                _loc_5.scale = _loc_5.poseInfo.scale;
            }
            var _loc_6:* = new FarAtkLight(param1);
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
                if (param1.q_fly_Penetrate)
                {
                    _loc_10 = ToolKit.getAngle(_loc_6.x, _loc_6.y, param1.targetX, param1.targetY - _loc_9) + param3;
                    _loc_6.flyByAngle(_loc_10, MapUtils.GRID_BORDER * param1.q_range_length, false, this.flyArrive, [_loc_5, param4]);
                }
                else
                {
                    _loc_6.fly(_loc_8._x, _loc_8._y - _loc_9, this.flyArrive, [_loc_5, param4], param3);
                }
            }
            else
            {
                _loc_10 = ToolKit.getAngle(_loc_6.x, _loc_6.y, param1.targetX, param1.targetY) + param3;
                _loc_6.flyByAngle(_loc_10, MapUtils.GRID_BORDER * param1.q_range_length, true, this.flyArrive, [_loc_5, param4]);
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

        public function showHit(param1:IRole, param2:IRole, param3:SkillInfo) : void
        {
            if (!param2)
            {
                return;
            }
            if (param2 && (param2.isMonster() || param2.isClientMonster()) && UICfg.NORMAL_MONSTER)
            {
                return;
            }
            if (param2.isPlayer() && UICfg.hideOtherPlayer && !param2.isUser())
            {
                return;
            }
            if (param3.hitURL)
            {
                if (!this.checkSkillShowNum(param1))
                {
                    return;
                }
                VMCManager.addRes(param3.hitURL, this.doShowHit, [param3.hitURL, param1, param2, param3, false]);
            }
            return;
        }// end function

        private function doShowHit(param1:String, param2:IRole, param3:IRole, param4:SkillInfo, param5:Boolean) : void
        {
            if (!param2 || !param2.info)
            {
                return;
            }
            if (VMCManager.getPoseInfo(param1, FrameworkGlobal.DIRECT_90.toString()))
            {
                this.showHitView(param1, "", param2, param3, param4, param5);
            }
            else
            {
                if (VMCManager.getPoseInfo(param1, "front_" + FrameworkGlobal.DIRECT_90.toString()))
                {
                    this.showHitView(param1, "front_", param2, param3, param4, param5);
                }
                if (VMCManager.getPoseInfo(param4.hitURL, "back_" + FrameworkGlobal.DIRECT_90.toString()))
                {
                    this.showHitView(param1, "back_", param2, param3, param4, param5);
                }
            }
            return;
        }// end function

        private function showHitView(param1:String, param2:String, param3:IRole, param4:IRole, param5:SkillInfo, param6:Boolean) : void
        {
            var _loc_8:* = NaN;
            var _loc_7:* = new VMCView();
            _loc_7.auto = true;
            _loc_7.direct = param3.direct;
            _loc_7.url = param1;
            _loc_7.updatePose(param2 + FrameworkGlobal.DIRECT_90.toString(), false, false, true, true);
            if (_loc_7.poseInfo.scale > 1)
            {
                _loc_7.scale = _loc_7.poseInfo.scale;
            }
            if (param4)
            {
                _loc_8 = param4.high * _loc_7.offsetY;
                if (_loc_8 > 100)
                {
                    _loc_8 = 100;
                }
            }
            if (param6)
            {
                if (param4)
                {
                    _loc_7.move(param4._x, param4._y - _loc_8);
                }
                else
                {
                    _loc_7.move(param5.targetX, param5.targetY);
                }
                if (param2 == "_back")
                {
                    this._bottomLayer.addChild(_loc_7);
                }
                else
                {
                    this._topLayer.addChild(_loc_7);
                }
            }
            else if (param4)
            {
                _loc_7.move(0, -_loc_8);
                if (param2 == "_back")
                {
                    param4.getSprite().addChildAt(_loc_7, 0);
                }
                else
                {
                    param4.getSprite().addChild(_loc_7);
                }
            }
            return;
        }// end function

        private function __playComplete() : void
        {
            if (this.currentSkillEffectNum > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.currentSkillEffectNum - 1;
                _loc_1.currentSkillEffectNum = _loc_2;
            }
            return;
        }// end function

        public function showFireSwordSkill(param1:EffectInfo, param2:Boolean = false) : void
        {
            var _loc_3:* = new SkillFireSwordView();
            _loc_3.move(param1.x, param1.y);
            this._bottomLayer.addChild(_loc_3);
            if (param2)
            {
                _loc_3.showSkillStep2(param1);
            }
            else
            {
                _loc_3.showSkillStep1(param1);
            }
            this.vecSkillFireSword.push(_loc_3);
            return;
        }// end function

        public function removeFireSwordSkill(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this.vecSkillFireSword.length)
                {
                    
                    _loc_2 = this.vecSkillFireSword[_loc_4];
                    if (_loc_2 && _loc_2.effect && param1[_loc_3].equal(_loc_2.effect.effectId))
                    {
                        this.vecSkillFireSword.splice(_loc_4, 1);
                        _loc_2.finalize();
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function showBrainStormSkill(param1:EffectInfo) : void
        {
            var _loc_2:* = new SkillBrainStormView();
            _loc_2.move(param1.x, param1.y);
            this._topLayer.addChild(_loc_2);
            _loc_2.showSkill(param1);
            this.vecSkillBrainStorm.push(_loc_2);
            return;
        }// end function

        public function removeBrainStormSkill(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this.vecSkillBrainStorm.length)
                {
                    
                    _loc_2 = this.vecSkillBrainStorm[_loc_4];
                    if (_loc_2 && _loc_2.effect && param1[_loc_3].equal(_loc_2.effect.effectId))
                    {
                        this.vecSkillBrainStorm.splice(_loc_4, 1);
                        _loc_2.finalize();
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

    }
}
