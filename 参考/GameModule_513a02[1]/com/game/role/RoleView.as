package com.game.role
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.map.control.*;
    import com.game.role.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.riaidea.text.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.role.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class RoleView extends BaseSprite implements IRoleView
    {
        private var _distanceToPlayer:uint;
        protected var _vIndex:int = 0;
        protected var _info:RoleInfo;
        protected var _bodyView:VMCView;
        protected var _weaponView:VMCView;
        protected var _otherWeaponView:VMCView;
        protected var _horseView:VMCView;
        protected var _horseWingView:VMCView;
        protected var _wingView:VMCView;
        protected var _otherWingView:VMCView;
        protected var _shadowViewNew:ShadowViewNew;
        protected var _frontBody:BaseSprite;
        protected var _backBody:BaseSprite;
        protected var _autoStand:Boolean = false;
        private var _currentSound:String;
        private var _currentActFlyTime:Number = 0;
        protected var _actType:String;
        protected var _fatherActType:String = "act01";
        protected var _repeat:Boolean = true;
        private var curIntervalTime:int = 1;
        protected var scrollMCBuffer:ScrollMCBuffer;
        protected var _shadowMC:Sprite;
        private var paopao:Sprite;
        private var speakDialog:RichTextField;
        private var fake_role:FakeRole;
        protected var _fly:Boolean;
        private var isShowBody:Boolean = true;
        private var _isShowHighLevelShadow:Boolean = false;
        private var _strengthView:VMCView;
        protected var _isShow:Boolean = true;
        private var _currentProgress:int = -1;
        public static const STRENGTH_11:String = "res/effect/equip_11.png";
        public static const STRENGTH_13:String = "res/effect/equip_13.png";

        public function RoleView()
        {
            this.initView();
            return;
        }// end function

        public function get isShow() : Boolean
        {
            return this._isShow;
        }// end function

        public function set isShow(param1:Boolean) : void
        {
            this._isShow = param1;
            return;
        }// end function

        public function get fly() : Boolean
        {
            return this._fly;
        }// end function

        public function set fly(param1:Boolean) : void
        {
            this._fly = param1;
            return;
        }// end function

        public function get distanceToPlayer() : uint
        {
            return this._distanceToPlayer;
        }// end function

        public function set distanceToPlayer(param1:uint) : void
        {
            this._distanceToPlayer = param1;
            return;
        }// end function

        public function get fatherActType() : String
        {
            return this._fatherActType;
        }// end function

        public function get poseInfo() : PoseInfo
        {
            return this._bodyView.poseInfo;
        }// end function

        public function get sex() : uint
        {
            return this._info.sex;
        }// end function

        public function set sex(param1:uint) : void
        {
            this._info.sex = param1;
            return;
        }// end function

        public function get actType() : String
        {
            if (this._info)
            {
                return this._info.actType;
            }
            return null;
        }// end function

        public function set actType(param1:String) : void
        {
            var _loc_2:* = param1;
            this._info.actType = param1;
            this._actType = _loc_2;
            return;
        }// end function

        private function initView() : void
        {
            this._bodyView = new VMCView();
            this._frontBody = new BaseSprite();
            this._backBody = new BaseSprite();
            this._bodyView.addEvtListener(Event.COMPLETE, this.__actComplete);
            addChild(this._backBody);
            addChild(this._bodyView);
            addChild(this._frontBody);
            return;
        }// end function

        public function set auto(param1:Boolean) : void
        {
            if (param1)
            {
                addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            else
            {
                removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            if (this._bodyView)
            {
                this._bodyView.hasSetAuto = param1;
            }
            return;
        }// end function

        public function get auto() : Boolean
        {
            return hasEventListener(Event.ENTER_FRAME);
        }// end function

        public function set info(param1:RoleInfo) : void
        {
            this._info = param1;
            if ((FrameworkGlobal.showHighLevelShadow || UserObj.getInstance().playerInfo.level <= FrameworkGlobal.showLightLevel) && !this.isCutePet() && !this.isMagicBook())
            {
                FrameworkGlobal.showHighLevelShadow = true;
                this.showHighLevelShadow(null);
            }
            else
            {
                this.makeShadow();
            }
            if (!this.isCutePet() && !this.isMagicBook())
            {
                FrameworkGlobal.addMsgListen("showShadow", this.showHighLevelShadow);
                FrameworkGlobal.addMsgListen("hideShadow", this.hideHighLevelShadow);
            }
            if (this._bodyView)
            {
                this._bodyView.filters = [];
                this._bodyView.clearAppendList();
            }
            if (this.alive())
            {
                if (this._fatherActType)
                {
                    this.setAct(this._fatherActType, true, false);
                }
            }
            if (this.isPlayer())
            {
                this.checkStrengthAll();
            }
            return;
        }// end function

        public function alive() : Boolean
        {
            if (this._info)
            {
                return this._info.alive();
            }
            return false;
        }// end function

        public function checkStrengthAll() : void
        {
            if (!this.isPlayer())
            {
                return;
            }
            if (this._info.allStrength >= 13)
            {
                if (this._strengthView && this._strengthView.url == STRENGTH_13)
                {
                    return;
                }
                VMCManager.addRes(STRENGTH_13, this.showStrengthView, [STRENGTH_13]);
            }
            else if (this._info.allStrength >= 11)
            {
                if (this._strengthView && this._strengthView.url == STRENGTH_11)
                {
                    return;
                }
                VMCManager.addRes(STRENGTH_11, this.showStrengthView, [STRENGTH_11]);
            }
            else if (this._strengthView)
            {
                this._strengthView.removeFromParent(true);
                this._strengthView = null;
            }
            return;
        }// end function

        private function showStrengthView(param1:String) : void
        {
            if (!this._strengthView)
            {
                this._strengthView = new VMCView();
                this._strengthView.auto = true;
                this.addRes(this._strengthView, 0, 1);
            }
            this._strengthView.url = param1;
            this._strengthView.updatePose("90", true);
            return;
        }// end function

        public function updateAct() : Boolean
        {
            if (this._repeat)
            {
                return this.setAct(this._fatherActType, this._repeat, this._autoStand);
            }
            return false;
        }// end function

        public function setAct(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false) : Boolean
        {
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_5:* = PlayerCfgObj.getInstance().checkAct(param1, this._fatherActType, this.isEffect(), this.isUser());
            if (PlayerCfgObj.getInstance().checkAct(param1, this._fatherActType, this.isEffect(), this.isUser()) == PlayerCfgObj.ACT_IMMEDIATELY || param4)
            {
                this._fatherActType = param1;
                if (this._info && this._info.weapon)
                {
                    if (this._info.weapon.q_secondary_type == ItemSecondaryType.TWO_HAND || this._info.weapon.q_hand == ItemHandType.TWO_HAND)
                    {
                        _loc_6 = true;
                    }
                }
                if (!this._info)
                {
                    Log.log("角色信息为空");
                    return false;
                }
                if (this._info.horseInfo && this._info.horseInfo.isRiding())
                {
                    _loc_7 = true;
                }
                else if (this._info.wingInfo)
                {
                    _loc_8 = true;
                }
                if (param1 == Params.ACTION_SIMPLE_ATTACK_ID)
                {
                    _loc_9 = this._info.currentSkill;
                    if (_loc_9)
                    {
                        if (_loc_6 && this._info.jobkind != JobType.WARRIOR)
                        {
                            if (_loc_9.q_attack_id_double)
                            {
                                param1 = _loc_9.q_attack_id_double;
                            }
                        }
                        else if (_loc_9.q_attack_id)
                        {
                            param1 = _loc_9.q_attack_id;
                        }
                    }
                    if (param1 == Params.ACTION_SIMPLE_ATTACK_ID && _loc_6)
                    {
                        param1 = Params.ACTION_TWO_HAND_SIMPLE_ATTACK_ID;
                    }
                }
                else if (param1 == Params.ACTION_STAND_ID)
                {
                    if (_loc_7)
                    {
                        param1 = this._info.horseInfo.q_horse_stand;
                    }
                    else if (_loc_8)
                    {
                        param1 = Params.ACTION_WING_STAND;
                    }
                    else if (this._fly)
                    {
                        param1 = Params.ACTION_FLY;
                    }
                    else if (_loc_6)
                    {
                        param1 = Params.ACTION_TWO_HAND_STAND_ID;
                    }
                }
                else if (param1 == Params.ACTION_RUN)
                {
                    if (_loc_7)
                    {
                        param1 = this._info.horseInfo.q_horse_move;
                    }
                    else if (_loc_8)
                    {
                        param1 = Params.ACTION_WING_RUN;
                    }
                    else if (this._fly)
                    {
                        param1 = Params.ACTION_FLY;
                    }
                    else if (_loc_6)
                    {
                        param1 = Params.ACTION_TWO_HAND_RUN;
                    }
                }
                else if (param1 == Params.ACTION_FLY)
                {
                    if (_loc_7)
                    {
                        param1 = this._info.horseInfo.q_horse_move;
                    }
                    else if (_loc_8)
                    {
                        param1 = Params.ACTION_WING_RUN;
                    }
                    else
                    {
                        param1 = Params.ACTION_FLY;
                    }
                }
                this._currentActFlyTime = 0;
                this._autoStand = param3;
                this._repeat = param2;
                this._bodyView.repeat = param2;
                this.actType = param1;
                this.loadRoleRes();
                return true;
            }
            return false;
        }// end function

        public function isLoadingRes() : Boolean
        {
            if (this._bodyView)
            {
                return this._bodyView.resLoading;
            }
            return false;
        }// end function

        protected function showView() : void
        {
            var _loc_2:* = 0;
            this.removeFake();
            dispatchEvt(new RoleEvent(RoleEvent.ACT_RES_LOADED));
            if (!this._info)
            {
                return;
            }
            var _loc_1:* = 1;
            if (this._fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
            {
                if (this._info.currentSkill && this.poseInfo)
                {
                    _loc_2 = this._info.currentSkill.q_public_cd - (this._info.attackspeed - 100) * 10;
                    _loc_2 = _loc_2 > Params.PUBLIC_CD_MIN ? (_loc_2) : (Params.PUBLIC_CD_MIN);
                    if (this.isMonster() && _loc_2 > 600)
                    {
                        _loc_2 = 600;
                    }
                    _loc_1 = _loc_2 / (1000 * this.poseInfo.lastTime);
                }
            }
            else if (this._fatherActType == Params.ACTION_RUN)
            {
                if (this.isMonster())
                {
                    _loc_1 = Params.MONSTER_RUN_ACT_DEFAULT_TIME / this._info.speed;
                }
                else
                {
                    _loc_1 = Params.PLAYER_RUN_ACT_DEFAULT_TIME / this._info.speed;
                }
            }
            this._bodyView.direct = this.direct;
            this._bodyView.playInterMultiple = _loc_1;
            this._bodyView.updatePose(Math.abs(this.direct).toString(), this._repeat, false, false, false);
            if (this.isPlayer() || this.isNPC())
            {
                this.updateWeaponOther();
                this.updateHorse();
                this.updateWing();
                this.updateWeapon();
            }
            return;
        }// end function

        private function loadViewFail() : void
        {
            this.removeFake();
            this.actComplete();
            return;
        }// end function

        override public function setVisible(param1:Boolean) : void
        {
            if (this._isShow != param1)
            {
                this._isShow = param1;
                if (!UICfg.OTHER_NORMAL_MODEL || !this.isPlayer())
                {
                    this.setViewVisible(this._bodyView, param1);
                }
                this.setViewVisible(this._weaponView, param1);
                this.setViewVisible(this._otherWeaponView, param1);
                this.setViewVisible(this._horseView, param1);
                this.setViewVisible(this._horseWingView, param1);
                this.setViewVisible(this._wingView, param1);
                this.setViewVisible(this._otherWingView, param1);
                this.setViewVisible(this._shadowViewNew, param1);
                this.setViewVisible(this._shadowMC, param1);
                this.setViewVisible(this._frontBody, param1);
                if (!param1)
                {
                    if (this._bodyView && !UICfg.OTHER_NORMAL_MODEL)
                    {
                        this._bodyView.url = null;
                    }
                    if (this._weaponView)
                    {
                        this._weaponView.url = null;
                    }
                    if (this._otherWeaponView)
                    {
                        this._otherWeaponView.url = null;
                    }
                    if (this._horseView)
                    {
                        this._horseView.url = null;
                    }
                    if (this._wingView)
                    {
                        this._wingView.url = null;
                    }
                    if (this._otherWingView)
                    {
                        this._otherWingView.url = null;
                    }
                    if (this._horseWingView)
                    {
                        this._horseWingView.url = null;
                    }
                }
                else
                {
                    this.loadRoleRes();
                }
            }
            return;
        }// end function

        public function hide() : void
        {
            this.setVisible(false);
            return;
        }// end function

        public function show() : void
        {
            this.setVisible(true);
            return;
        }// end function

        protected function setViewVisible(param1:DisplayObject, param2:Boolean) : void
        {
            if (param1 && param1.visible != param2)
            {
                param1.visible = param2;
            }
            return;
        }// end function

        protected function updateViewLayout() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            switch(this.direct)
            {
                case FrameworkGlobal.DIRECT_0:
                {
                    if (this._horseView)
                    {
                        _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._horseView, this._horseWingView, this._bodyView, this._wingView, this._otherWeaponView, this._weaponView, this._otherWingView, this._frontBody];
                    }
                    else
                    {
                        _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._horseView, this._horseWingView, this._bodyView, this._otherWeaponView, this._weaponView, this._wingView, this._otherWingView, this._frontBody];
                    }
                    break;
                }
                case FrameworkGlobal.DIRECT_45:
                case -FrameworkGlobal.DIRECT_45:
                {
                    if (this._horseView)
                    {
                        _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._horseView, this._bodyView, this._weaponView, this._wingView, this._otherWeaponView, this._horseWingView, this._otherWingView, this._frontBody];
                    }
                    else
                    {
                        _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._horseView, this._bodyView, this._otherWeaponView, this._weaponView, this._wingView, this._horseWingView, this._otherWingView, this._frontBody];
                    }
                    break;
                }
                case FrameworkGlobal.DIRECT_135:
                case -FrameworkGlobal.DIRECT_135:
                {
                    _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._horseView, this._wingView, this._bodyView, this._otherWeaponView, this._weaponView, this._horseWingView, this._otherWingView, this._frontBody];
                    break;
                }
                case FrameworkGlobal.DIRECT_90:
                case -FrameworkGlobal.DIRECT_90:
                {
                    _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._horseView, this._wingView, this._bodyView, this._otherWeaponView, this._weaponView, this._horseWingView, this._otherWingView, this._frontBody];
                    break;
                }
                case FrameworkGlobal.DIRECT_180:
                {
                    _loc_2 = [this._shadowMC, this._backBody, this._shadowViewNew, this._wingView, this._horseView, this._bodyView, this._otherWeaponView, this._weaponView, this._horseWingView, this._otherWingView, this._frontBody];
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = _loc_2 != null ? (_loc_2.length) : (0);
            var _loc_4:* = this._vIndex;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_1 = _loc_2[_loc_5];
                if (_loc_1)
                {
                    if (_loc_1.parent == this)
                    {
                        if (getChildIndex(_loc_1) != _loc_4)
                        {
                            setChildIndex(_loc_1, _loc_4);
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        protected function addStrengthURL(param1:String, param2:ItemCfg, param3:String = "") : String
        {
            if (param2 && param2.streng >= 7)
            {
                if (param2.streng >= 9)
                {
                    param1 = param1 + "09";
                }
                else
                {
                    param1 = param1 + "07";
                }
            }
            else
            {
                param1 = param1 + param3;
            }
            return param1;
        }// end function

        private function removeAppend(param1:VMCView) : void
        {
            if (this._bodyView)
            {
                this._bodyView.removeAppend(param1);
            }
            return;
        }// end function

        public function updateWeapon() : void
        {
            if (!this._info)
            {
                return;
            }
            if (UICfg.OTHER_NORMAL_MODEL && !this.isUser())
            {
                return;
            }
            if (this._info.weapon)
            {
                if (!this._weaponView)
                {
                    this._weaponView = new VMCView();
                }
                if (this._weaponView && this._weaponView.parent != this)
                {
                    addChild(this._weaponView);
                }
                this.loadWeaponRes();
                this.updateViewLayout();
            }
            else if (this._weaponView)
            {
                this.removeAppend(this._weaponView);
                this._weaponView.removeFromParent();
                this._weaponView = null;
            }
            return;
        }// end function

        public function loadWeaponRes() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            if (this._weaponView)
            {
                _loc_1 = Params.WEAPON_PATH + this._info.weapon.q_equip_resource;
                _loc_2 = this.actType;
                if (this._info.jobkind == JobType.WARRIOR)
                {
                    if (this._fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
                    {
                        _loc_4 = this._info.currentSkill;
                        if (_loc_4)
                        {
                            if (this._info.weapon.q_secondary_type == ItemSecondaryType.TWO_HAND || this._info.weapon.q_hand == ItemHandType.TWO_HAND)
                            {
                                _loc_3 = true;
                            }
                            if (_loc_3)
                            {
                                if (_loc_4.q_attack_id_double)
                                {
                                    _loc_2 = _loc_4.q_attack_id_double;
                                }
                            }
                            else if (_loc_4.q_attack_id)
                            {
                                _loc_2 = _loc_4.q_attack_id;
                            }
                        }
                    }
                }
                _loc_2 = this.chehckRideActType(_loc_2);
                _loc_1 = this.addStrengthURL(_loc_1, this._info.weapon) + "/" + _loc_2 + ".png";
                if (_loc_1 == this._weaponView.url)
                {
                    if (!this._repeat)
                    {
                        this._weaponView.replay();
                    }
                    return;
                }
                this._weaponView.url = _loc_1;
                if (VMCManager.addRes(_loc_1, this.showWeaponView, null, this.loadWeaponFail, null, this.ifKeep(), FrameworkGlobal.LOAD_PRELOAD_WEAPON))
                {
                    this.setViewVisible(this._weaponView, false);
                }
            }
            return;
        }// end function

        private function chehckRideActType(param1:String) : String
        {
            if (param1 == "act23" || param1 == "act25")
            {
                return Params.ACTION_SIMPLE_RIDE_STAND;
            }
            if (param1 == "act24" || param1 == "act26")
            {
                return Params.ACTION_SIMPLE_RIDE_RUN;
            }
            return param1;
        }// end function

        public function updateWeaponOther() : void
        {
            if (!this._info)
            {
                return;
            }
            if (UICfg.OTHER_NORMAL_MODEL && !this.isUser())
            {
                return;
            }
            if (this._info.weapon_other)
            {
                if (!this._otherWeaponView)
                {
                    this._otherWeaponView = new VMCView();
                }
                if (this._otherWeaponView && this._otherWeaponView.parent != this)
                {
                    addChild(this._otherWeaponView);
                }
                this.loadWeaponOtherRes();
                this.updateViewLayout();
            }
            else if (this._otherWeaponView)
            {
                this.removeAppend(this._otherWeaponView);
                this._otherWeaponView.removeFromParent();
                this._otherWeaponView = null;
            }
            return;
        }// end function

        public function loadWeaponOtherRes() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._otherWeaponView)
            {
                _loc_1 = this.actType;
                _loc_1 = this.chehckRideActType(_loc_1);
                _loc_2 = Params.WEAPON_PATH + this._info.weapon_other.q_equip_resource + "01";
                _loc_2 = this.addStrengthURL(_loc_2, this._info.weapon_other, "") + "/" + _loc_1 + ".png";
                _loc_2 = this.chehckRideActType(_loc_2);
                if (_loc_2 == this._otherWeaponView.url)
                {
                    if (!this._repeat)
                    {
                        this._otherWeaponView.replay();
                    }
                    return;
                }
                this._otherWeaponView.url = _loc_2;
                if (VMCManager.addRes(_loc_2, this.showWeaponOtherView, null, this.loadWeaponOtherFail, null, this.ifKeep(), FrameworkGlobal.LOAD_PRELOAD_WEAPON))
                {
                    this.setViewVisible(this._otherWeaponView, false);
                }
            }
            return;
        }// end function

        public function updateWing() : void
        {
            if (!this._info)
            {
                return;
            }
            if (UICfg.OTHER_NORMAL_MODEL && !this.isUser())
            {
                return;
            }
            if (this._info.wingInfo)
            {
                if (!this._wingView)
                {
                    this._wingView = new VMCView();
                }
                if (this._wingView && this._wingView.parent != this)
                {
                    addChild(this._wingView);
                }
                this.loadWingRes();
                this.updateViewLayout();
            }
            else if (this._wingView)
            {
                this.removeAppend(this._wingView);
                this._wingView.removeFromParent(true);
                this._wingView = null;
            }
            this.updateOtherWing();
            if (this._horseView && this._horseView.poseInfo)
            {
                if (this._wingView)
                {
                    this._wingView._y = this._horseView.horseY;
                }
                if (this._bodyView)
                {
                    this._bodyView._y = this._horseView.horseY;
                }
            }
            else
            {
                if (this._wingView)
                {
                    this._wingView._y = 0;
                }
                if (this._bodyView)
                {
                    this._bodyView._y = 0;
                }
            }
            return;
        }// end function

        public function loadWingRes() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._info && this._info.wingInfo)
            {
                if (this._wingView)
                {
                    _loc_1 = this.actType;
                    _loc_1 = this.chehckRideActType(_loc_1);
                    _loc_2 = Params.WING_PATH + "gen/" + this._info.wingInfo.q_equip_resource + "/" + _loc_1 + "/" + Math.abs(this.direct) + ".png";
                    _loc_2 = this.chehckRideActType(_loc_2);
                    if (_loc_2 == this._wingView.url)
                    {
                        if (this._repeat)
                        {
                        }
                        else
                        {
                            this._wingView.replay();
                        }
                        return;
                    }
                    this._wingView.url = _loc_2;
                    if (VMCManager.addRes(_loc_2, this.showWingView, null, this.loadWingFail, null, this.ifKeep(), this.isUser() ? (FrameworkGlobal.LOAD_PRELOAD_PRI_ROLE_WING) : (FrameworkGlobal.LOAD_PRELOAD_WING)))
                    {
                        this.setViewVisible(this._wingView, false);
                    }
                }
            }
            return;
        }// end function

        protected function get needShowOtherWing() : Boolean
        {
            return this.direct == FrameworkGlobal.DIRECT_90 || this.direct == -FrameworkGlobal.DIRECT_90;
        }// end function

        public function updateOtherWing() : void
        {
            if (!this._info)
            {
                return;
            }
            if (this._info.wingInfo)
            {
                if (this.needShowOtherWing)
                {
                    if (!this._otherWingView)
                    {
                        this._otherWingView = new VMCView();
                    }
                    if (this._otherWingView && this._otherWingView.parent != this)
                    {
                        addChild(this._otherWingView);
                    }
                    this.loadOtherWingRes();
                    this.updateViewLayout();
                }
                else if (this._otherWingView)
                {
                    this._otherWingView.removeFromParent(false);
                    this.removeAppend(this._otherWingView);
                }
            }
            else if (this._otherWingView)
            {
                this.removeAppend(this._otherWingView);
                this._otherWingView.removeFromParent(true);
                this._otherWingView = null;
            }
            return;
        }// end function

        public function loadOtherWingRes() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._info && this._info.wingInfo)
            {
                if (this._otherWingView)
                {
                    _loc_1 = this.actType;
                    _loc_1 = this.chehckRideActType(_loc_1);
                    _loc_2 = Params.WING_PATH + "gen/" + this._info.wingInfo.q_equip_resource + "/" + _loc_1 + "01/" + Math.abs(this.direct) + ".png";
                    _loc_2 = this.chehckRideActType(_loc_2);
                    if (_loc_2 == this._otherWingView.url)
                    {
                        if (this._bodyView)
                        {
                            this._bodyView.appendView(this._otherWingView);
                        }
                        if (this._repeat)
                        {
                        }
                        else
                        {
                            this._otherWingView.replay();
                        }
                        return;
                    }
                    this._otherWingView.url = _loc_2;
                    this._otherWingView.direct = this.direct;
                    if (VMCManager.addRes(_loc_2, this.showOtherWingView, null, this.loadOtherWingFail, null, this.ifKeep(), this.isUser() ? (FrameworkGlobal.LOAD_PRELOAD_PRI_ROLE_WING) : (FrameworkGlobal.LOAD_PRELOAD_WING)))
                    {
                        this.setViewVisible(this._otherWingView, false);
                    }
                }
            }
            return;
        }// end function

        public function updateHorse() : void
        {
            if (!this._info)
            {
                return;
            }
            if (UICfg.OTHER_NORMAL_MODEL && !this.isUser())
            {
                return;
            }
            if (this._info.horseInfo && this._info.horseInfo.isRiding())
            {
                if (this._horseView == null)
                {
                    this._horseView = new VMCView();
                }
                if (this._horseView && this._horseView.parent != this)
                {
                    addChild(this._horseView);
                }
                this.loadHorseRes();
                if (this._info.horseInfo.q_horse_wing == 1)
                {
                    if (this._horseWingView == null)
                    {
                        this._horseWingView = new VMCView();
                    }
                    if (this._horseWingView && this._horseWingView.parent != this)
                    {
                        addChild(this._horseWingView);
                    }
                    this.loadHorseWingRes();
                }
                else if (this._horseWingView)
                {
                    this.removeAppend(this._horseWingView);
                    this._horseWingView.removeFromParent(true);
                    this._horseWingView = null;
                }
                this.updateViewLayout();
            }
            else
            {
                if (this._horseView)
                {
                    this.removeAppend(this._horseView);
                    this._horseView.removeFromParent(true);
                    this._horseView = null;
                }
                if (this._horseWingView)
                {
                    this.removeAppend(this._horseWingView);
                    this._horseWingView.removeFromParent(true);
                    this._horseWingView = null;
                }
                if (this._bodyView)
                {
                    this._bodyView._y = 0;
                }
                if (this._wingView)
                {
                    this._wingView._y = 0;
                }
                if (this._otherWingView)
                {
                    this._otherWingView._y = 0;
                }
                if (this._weaponView)
                {
                    this._weaponView._y = 0;
                }
                if (this._otherWeaponView)
                {
                    this._otherWeaponView._y = 0;
                }
            }
            return;
        }// end function

        public function loadHorseRes() : void
        {
            var _loc_1:* = null;
            if (this._info && this._info.horseInfo)
            {
                if (this._horseView)
                {
                    _loc_1 = Params.HORSE_PATH + this._info.horseInfo.horse_id + "/" + this._fatherActType + "/" + Math.abs(this.direct) + ".png";
                    if (_loc_1 == this._horseView.url)
                    {
                        if (this._repeat)
                        {
                        }
                        else
                        {
                            this._horseView.replay();
                        }
                        return;
                    }
                    this._horseView.url = _loc_1;
                    this._horseView.direct = this.direct;
                    if (VMCManager.addRes(_loc_1, this.showHorseView, null, this.loadHorseFail, null, false, this.isUser() ? (FrameworkGlobal.LOAD_PRELOAD_PRI_ROLE_HORSE) : (FrameworkGlobal.LOAD_PRELOAD_HORSE)))
                    {
                        this.setViewVisible(this._horseView, false);
                    }
                }
            }
            return;
        }// end function

        public function loadHorseWingRes() : void
        {
            var _loc_1:* = null;
            if (this._info && this._info.horseInfo)
            {
                if (this._horseWingView)
                {
                    _loc_1 = Params.HORSE_PATH + this._info.horseInfo.horse_id + "01/" + this._fatherActType + "/" + Math.abs(this.direct) + ".png";
                    if (_loc_1 == this._horseWingView.url)
                    {
                        if (this._repeat)
                        {
                        }
                        else
                        {
                            this._horseWingView.replay();
                        }
                        return;
                    }
                    this._horseWingView.url = _loc_1;
                    this._horseWingView.direct = this.direct;
                    if (VMCManager.addRes(_loc_1, this.showHorseWingView, null, this.loadHorseWingFail, null, false, this.isUser() ? (FrameworkGlobal.LOAD_PRELOAD_PRI_ROLE_HORSE) : (FrameworkGlobal.LOAD_PRELOAD_HORSE)))
                    {
                        this.setViewVisible(this._horseWingView, false);
                    }
                }
            }
            return;
        }// end function

        protected function showHorseView() : void
        {
            if (this._bodyView && this._horseView)
            {
                this.setViewVisible(this._horseView, this._bodyView.visible);
                this._horseView.direct = this.direct;
                this._horseView.poseInfo = VMCManager.getPoseInfo(this._horseView.url, Math.abs(this.direct).toString());
                this._bodyView.appendView(this._horseView);
                if (this._horseView.poseInfo)
                {
                    if (this._bodyView)
                    {
                        this._bodyView._y = this._horseView.horseY;
                    }
                    if (this._wingView)
                    {
                        this._wingView._y = this._horseView.horseY;
                    }
                    if (this._otherWingView)
                    {
                        this._otherWingView._y = this._horseView.horseY;
                    }
                    if (this._weaponView)
                    {
                        this._weaponView._y = this._horseView.horseY;
                    }
                    if (this._otherWeaponView)
                    {
                        this._otherWeaponView._y = this._horseView.horseY;
                    }
                }
                else
                {
                    if (this._bodyView)
                    {
                        this._bodyView._y = 0;
                    }
                    if (this._wingView)
                    {
                        this._wingView._y = 0;
                    }
                    if (this._otherWingView)
                    {
                        this._otherWingView._y = 0;
                    }
                    if (this._weaponView)
                    {
                        this._weaponView._y = 0;
                    }
                    if (this._otherWeaponView)
                    {
                        this._otherWeaponView._y = 0;
                    }
                }
            }
            return;
        }// end function

        private function loadHorseFail() : void
        {
            if (this._horseView)
            {
                this.removeAppend(this._horseView);
                this._horseView.removeFromParent();
                this._horseView = null;
            }
            return;
        }// end function

        protected function showHorseWingView() : void
        {
            if (this._bodyView && this._horseWingView)
            {
                this.setViewVisible(this._horseWingView, this._bodyView.visible);
                this._horseWingView.direct = this.direct;
                this._horseWingView.poseInfo = VMCManager.getPoseInfo(this._horseWingView.url, Math.abs(this.direct).toString());
                this._bodyView.appendView(this._horseWingView);
            }
            return;
        }// end function

        private function loadHorseWingFail() : void
        {
            if (this._horseWingView)
            {
                this.removeAppend(this._horseWingView);
                this._horseWingView.removeFromParent();
                this._horseWingView = null;
            }
            return;
        }// end function

        protected function showOtherWingView() : void
        {
            if (this._bodyView && this._otherWingView)
            {
                this.setViewVisible(this._otherWingView, this._bodyView.visible);
                this._otherWingView.direct = this.direct;
                this._otherWingView.poseInfo = VMCManager.getPoseInfo(this._otherWingView.url, Math.abs(this.direct).toString());
                this._bodyView.appendView(this._otherWingView);
            }
            return;
        }// end function

        private function loadOtherWingFail() : void
        {
            if (this._otherWingView)
            {
                this.removeAppend(this._otherWingView);
                this._otherWingView.removeFromParent(true);
                this._otherWingView = null;
            }
            return;
        }// end function

        protected function showWingView() : void
        {
            if (this._bodyView && this._wingView)
            {
                this.setViewVisible(this._wingView, this._bodyView.visible);
                this._wingView.direct = this.direct;
                this._wingView.poseInfo = VMCManager.getPoseInfo(this._wingView.url, Math.abs(this.direct).toString());
                this._bodyView.appendView(this._wingView);
            }
            return;
        }// end function

        private function loadWingFail() : void
        {
            if (this._wingView)
            {
                this.removeAppend(this._wingView);
                this._wingView.removeFromParent();
                this._wingView = null;
            }
            return;
        }// end function

        protected function showWeaponOtherView() : void
        {
            if (this._bodyView && this._otherWeaponView)
            {
                this.setViewVisible(this._otherWeaponView, this._bodyView.visible);
                this._otherWeaponView.direct = this.direct;
                this._otherWeaponView.poseInfo = VMCManager.getPoseInfo(this._otherWeaponView.url, Math.abs(this.direct).toString());
                this._bodyView.appendView(this._otherWeaponView);
            }
            return;
        }// end function

        private function loadWeaponOtherFail() : void
        {
            if (this._otherWeaponView)
            {
                this.removeAppend(this._otherWeaponView);
                this._otherWeaponView.removeFromParent();
                this._otherWeaponView = null;
            }
            return;
        }// end function

        protected function showWeaponView() : void
        {
            if (this._bodyView && this._weaponView)
            {
                this.setViewVisible(this._weaponView, this._bodyView.visible);
                this._weaponView.direct = this.direct;
                this._weaponView.poseInfo = VMCManager.getPoseInfo(this._weaponView.url, Math.abs(this.direct).toString());
                this._bodyView.appendView(this._weaponView);
            }
            return;
        }// end function

        private function loadWeaponFail() : void
        {
            if (this._weaponView)
            {
                this.removeAppend(this._weaponView);
                this._weaponView.removeFromParent();
                this._weaponView = null;
            }
            return;
        }// end function

        public function get direct() : int
        {
            if (this._info)
            {
                return this._info.direct;
            }
            return 0;
        }// end function

        public function set direct(param1:int) : void
        {
            if (!this._info)
            {
                return;
            }
            if (this._info.direct != param1)
            {
                this._info.direct = param1;
                this.loadRoleRes();
            }
            if (this._bodyView && this._bodyView.direct != param1)
            {
                this._bodyView.direct = param1;
            }
            if (!this.needShowOtherWing)
            {
                if (this._otherWingView)
                {
                    this._otherWingView.removeFromParent(false);
                }
            }
            if (this._wingView && this._wingView.parent == this)
            {
                this.updateViewLayout();
            }
            if (this._wingView && this._wingView.parent == this)
            {
                this.updateViewLayout();
            }
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_DIRECT));
            return;
        }// end function

        public function updatePosition() : void
        {
            move(this._info.x, this._info.y);
            return;
        }// end function

        private function __actComplete(event:Event = null) : void
        {
            this.actComplete();
            return;
        }// end function

        protected function actComplete() : void
        {
            if (!this._info)
            {
                return;
            }
            if (this._autoStand)
            {
                if (this.actType != Params.ACTION_STAND_ID)
                {
                    this.actType = null;
                    this._fatherActType = null;
                    this.setAct(Params.ACTION_STAND_ID, true, false);
                }
            }
            else if (this._bodyView != null)
            {
                if (this.isUser())
                {
                }
                this._bodyView.stop();
            }
            dispatchEvent(new RoleEvent(RoleEvent.ACTION_COMPLETE, this.actType));
            return;
        }// end function

        public function loadRoleRes() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this._isShow)
            {
                return;
            }
            if (!this._info)
            {
                return;
            }
            var _loc_1:* = this.addStrengthURL(this._info.url, this._info.armor) + "/" + this.actType + "/" + Math.abs(this.direct) + ".png";
            if (this._info.roleType == RoleType.ROLE_TYPE_NPC)
            {
                _loc_2 = this._info.url.lastIndexOf("/");
                _loc_3 = this._info.url.slice((_loc_2 + 1));
                _loc_4 = _loc_3.split(";");
                if (_loc_4.length > 1)
                {
                    _loc_2 = this._info.url.lastIndexOf(";");
                    this._info.url = this._info.url.slice(0, _loc_2);
                    this.actType = Params.ACTION_WING_STAND;
                    _loc_1 = this._info.url + "/" + this.actType + ".png";
                    _loc_5 = new ItemCfg();
                    _loc_5.q_equip_resource = _loc_4[1];
                    this._info.wingInfo = _loc_5;
                }
            }
            if (!LoadHelper.getTrueURL(_loc_1))
            {
                this.actComplete();
                return;
            }
            if (_loc_1 == this._bodyView.url)
            {
                if (this._repeat)
                {
                }
                else
                {
                    this._bodyView.replay();
                }
                if (this.isPlayer() || this.isNPC())
                {
                    this.updateWeaponOther();
                    if (!this._repeat)
                    {
                        this.updateHorse();
                    }
                    this.updateWing();
                    this.updateWeapon();
                }
                return;
            }
            if (this._bodyView.loadRes(_loc_1, Params.DEFAULT_ROLE_RES, this.ifKeep(), this.showView, null, this.setFakeProgress, this.loadViewFail, this.isUser() ? (FrameworkGlobal.LOAD_PRELOAD_PRI_ROLE) : (FrameworkGlobal.LOAD_PRELOAD_ROLE)))
            {
                this.showFake();
            }
            return;
        }// end function

        protected function ifKeep() : Boolean
        {
            return this.isUser() && this._fatherActType != Params.ACTION_SIMPLE_ATTACK_ID || this.isPlayerCutePet();
        }// end function

        public function enterFrame(event:Event = null) : void
        {
            if (this._isShow)
            {
                this._bodyView.enterFrame();
            }
            if (this._bodyView.poseProgress != this._currentProgress)
            {
                this._currentProgress = this._bodyView.poseProgress;
                this.showShadowNew();
            }
            return;
        }// end function

        private function showShadowNew() : void
        {
            if (this._isShowHighLevelShadow && this._info)
            {
                if (this._shadowViewNew)
                {
                    this._shadowViewNew.programDrawShadow([this._bodyView, this._horseView, this._weaponView, this._otherWeaponView, this._wingView, this._horseWingView], this.direct <= 0, this.isPlayer());
                }
            }
            return;
        }// end function

        public function showHighLevelShadow(event:Event) : void
        {
            this._isShowHighLevelShadow = true;
            if (this._shadowViewNew == null)
            {
                this._shadowViewNew = new ShadowViewNew();
                addChildAt(this._shadowViewNew, 0);
            }
            this.hideShadow();
            return;
        }// end function

        public function hideHighLevelShadow(event:Event) : void
        {
            this._isShowHighLevelShadow = false;
            if (this._shadowViewNew && this._shadowViewNew.parent)
            {
                removeChild(this._shadowViewNew);
                this._shadowViewNew = null;
            }
            this.makeShadow();
            return;
        }// end function

        private function showFake() : void
        {
            TweenLite.delayedCall(0.6, this.doShowFake);
            this.setViewVisible(this._bodyView, false);
            return;
        }// end function

        private function doShowFake() : void
        {
            if (!this.fake_role)
            {
                this.fake_role = new FakeRole();
            }
            if (this.isShowBody)
            {
                addChild(this.fake_role);
            }
            return;
        }// end function

        protected function removeFake() : void
        {
            TweenLite.killDelayedCallsTo(this.doShowFake);
            if (this.fake_role && this.fake_role.parent)
            {
                removeChild(this.fake_role);
                this.fake_role = null;
            }
            this.setViewVisible(this._bodyView, true);
            return;
        }// end function

        private function setFakeProgress(param1:uint) : void
        {
            if (this.fake_role)
            {
                this.fake_role.setProgress(param1);
            }
            return;
        }// end function

        public function get info() : RoleInfo
        {
            return this._info;
        }// end function

        public function set scale(param1:Number) : void
        {
            if (this._bodyView)
            {
                this._bodyView.scale = param1;
            }
            return;
        }// end function

        public function get scale() : Number
        {
            if (this._bodyView && this._bodyView.width > 0)
            {
                return this._bodyView.scale;
            }
            return 1;
        }// end function

        public function get bodyView() : VMCView
        {
            return this._bodyView;
        }// end function

        public function speak(param1:String) : void
        {
            if (this.paopao == null)
            {
                this.initPaopao();
            }
            this.stopSpeak();
            this.speakDialog.append(param1);
            this.layoutPaopao(param1);
            addChild(this.paopao);
            addChild(this.speakDialog);
            return;
        }// end function

        public function richSpeak(param1:String, param2:Array = null, param3:Boolean = false, param4:TextFormat = null, param5:int = 0) : void
        {
            if (this.paopao == null)
            {
                this.initPaopao();
            }
            this.stopSpeak();
            this.speakDialog.append(param1, param2, param3, param4);
            this.layoutPaopao(param1, param2, param3, param4);
            TweenLite.killDelayedCallsTo(this.stopSpeak);
            addChild(this.paopao);
            addChild(this.speakDialog);
            if (param5 != 0)
            {
                TweenLite.delayedCall(param5, this.stopSpeak);
            }
            return;
        }// end function

        private function layoutPaopao(param1:String, param2:Array = null, param3:Boolean = false, param4:TextFormat = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this.paopao)
            {
                _loc_5 = this.speakDialog.textfield.textWidth + 4;
                _loc_6 = this.speakDialog.textfield.textHeight + 8;
                if (_loc_5 < 50)
                {
                    _loc_5 = 50;
                }
                if (_loc_6 <= this.speakDialog.height)
                {
                    _loc_6 = this.speakDialog.height;
                }
                this.speakDialog.setSize(152, _loc_6);
                this.paopao["bg"].width = _loc_5 + 18;
                this.paopao["bg"].height = _loc_6 + 18;
                this.paopao["arrow"].x = this.paopao["bg"].width - this.paopao["arrow"].width >> 1;
                this.paopao["arrow"].y = this.paopao["bg"].height - 4;
                this.paopao.height = _loc_6 + 19;
                this.paopao.x = -this.paopao.width >> 1;
                this.paopao.y = -this.high - this.paopao.height;
                this.speakDialog.x = this.paopao.x + 9;
                this.speakDialog.y = this.paopao.y + 9;
            }
            return;
        }// end function

        private function initPaopao() : void
        {
            var _loc_1:* = null;
            if (this.paopao == null)
            {
                this.paopao = ToolKit.getNew("commonSpeakBox");
                this.speakDialog = new RichTextField();
                this.speakDialog.type = RichTextField.DYNAMIC;
                _loc_1 = new TextFormat("SimSun", 12, 14604487, false, false, false);
                _loc_1.leading = 5;
                this.speakDialog.defaultTextFormat = _loc_1;
                this.speakDialog.textfield.mouseWheelEnabled = false;
                this.speakDialog.textfield.selectable = false;
                this.speakDialog.textfield.filters = [FrameworkGlobal.BLACK_FILTER];
                this.speakDialog.autoScroll = false;
                this.speakDialog.html = true;
                this.speakDialog.setSize(152, 40);
            }
            return;
        }// end function

        public function stopSpeak() : void
        {
            if (this.paopao != null)
            {
                TweenLite.killDelayedCallsTo(this.stopSpeak);
                this.speakDialog.clear();
                if (this.paopao.parent)
                {
                    removeChild(this.paopao);
                    removeChild(this.speakDialog);
                }
                this.speakDialog.setSize(152, this.speakDialog.textfield.textHeight + 4);
            }
            return;
        }// end function

        public function isSpeaking() : Boolean
        {
            if (this.paopao && this.speakDialog.visible)
            {
                return true;
            }
            return false;
        }// end function

        public function isStand() : Boolean
        {
            return this._fatherActType == Params.ACTION_STAND_ID;
        }// end function

        public function get high() : uint
        {
            if (this._bodyView && this._bodyView.width > 0)
            {
                return -this._bodyView.y;
            }
            return 130;
        }// end function

        public function get wild() : uint
        {
            return this._bodyView.width;
        }// end function

        protected function makeShadow() : void
        {
            if (!this._shadowMC)
            {
                if (UICfg.OTHER_NORMAL_MODEL)
                {
                    this._shadowMC = ToolKit.getNew("shadow3");
                }
                else
                {
                    this._shadowMC = ToolKit.getNew("shadow2");
                }
            }
            if (this._shadowMC)
            {
                var _loc_1:* = false;
                this._shadowMC.mouseEnabled = false;
                this._shadowMC.mouseChildren = _loc_1;
                addChildAt(this._shadowMC, 0);
            }
            return;
        }// end function

        protected function changeToSimpleShadow() : void
        {
            if (this._shadowMC != null)
            {
                if (this._shadowMC.parent == this)
                {
                    removeChild(this._shadowMC);
                }
                this._shadowMC = null;
            }
            this.makeShadow();
            return;
        }// end function

        public function hideShadow() : void
        {
            if (this._shadowMC != null)
            {
                if (this._shadowMC.parent == this)
                {
                    removeChild(this._shadowMC);
                }
                this._shadowMC = null;
            }
            return;
        }// end function

        public function setShowing(param1:Boolean) : void
        {
            this.isShowBody = param1;
            if (this._bodyView)
            {
                if (param1)
                {
                    addChildAt(this._bodyView, 0);
                }
                else if (contains(this._bodyView))
                {
                    removeChild(this._bodyView);
                }
            }
            if (this.fake_role)
            {
                if (param1)
                {
                    addChildAt(this.fake_role, 0);
                }
                else if (contains(this.fake_role))
                {
                    removeChild(this.fake_role);
                }
            }
            if (this._shadowMC)
            {
                if (param1)
                {
                    addChildAt(this._shadowMC, 0);
                }
                else if (contains(this._shadowMC))
                {
                    removeChild(this._shadowMC);
                }
            }
            return;
        }// end function

        public function get currentActReleaseTime() : Number
        {
            if (this._bodyView && this._bodyView.poseInfo)
            {
                return this._bodyView.releaseTime * this._bodyView.playInterMultiple;
            }
            return 0;
        }// end function

        public function get currentActEffectTime() : Number
        {
            if (this._bodyView && this._bodyView.poseInfo)
            {
                return this._bodyView.effectTime * this._bodyView.playInterMultiple;
            }
            return 0;
        }// end function

        public function get currentActFlyTime() : Number
        {
            return this._currentActFlyTime;
        }// end function

        public function set currentActFlyTime(param1:Number) : void
        {
            this._currentActFlyTime = param1;
            return;
        }// end function

        public function get bmp() : BMPView
        {
            return this._bodyView;
        }// end function

        public function addRes(param1, param2:Number = 0.5, param3:uint = 1, param4:uint = 0) : DisplayObject
        {
            var _loc_5:* = null;
            if (param1 && param1 != "")
            {
                if (param1 is String)
                {
                    _loc_5 = ToolKit.getNew(param1);
                }
                else if (param1 is DisplayObject)
                {
                    _loc_5 = param1;
                }
                else
                {
                    return null;
                }
                if (_loc_5)
                {
                    this.doAddRes(_loc_5, param2, param3, param4);
                    return _loc_5;
                }
            }
            return null;
        }// end function

        public function doAddRes(param1:DisplayObject, param2:Number, param3:uint, param4:uint = 0) : void
        {
            if (!param1)
            {
                return;
            }
            if (!this._info)
            {
                return;
            }
            if (param1 is MovieClip)
            {
                (param1 as MovieClip).gotoAndPlay(1);
            }
            if (this.direct > 0)
            {
                if (param1 is VMCView)
                {
                    (param1 as VMCView).direct = this.direct;
                }
                else
                {
                    param1.scaleX = -1;
                }
            }
            else
            {
                param1.scaleX = 1;
            }
            if (param1 is VMCView)
            {
                (param1 as VMCView)._y = -param4;
            }
            else
            {
                param1.y = -param4;
            }
            if (param3 == 1)
            {
                this._frontBody.addChild(param1);
            }
            else
            {
                this._backBody.addChildAt(param1, 0);
            }
            if (param2 > 0)
            {
                TweenLite.delayedCall(param2, this.removeRes, [param1]);
            }
            return;
        }// end function

        protected function removeRes(param1:DisplayObject) : void
        {
            if (param1 != null && param1.parent == this)
            {
                removeChild(param1);
                if (param1 is MovieClip)
                {
                    (param1 as MovieClip).gotoAndStop(1);
                }
            }
            return;
        }// end function

        public function addIcon(param1:String = "") : void
        {
            var _loc_2:* = null;
            if (param1 != "")
            {
                _loc_2 = ToolKit.getNew(param1);
                _loc_2.y = -this.high - 40;
                _loc_2.x = (-_loc_2.width) / 2;
                addChild(_loc_2);
            }
            return;
        }// end function

        public function shine(param1:uint = 16773120) : void
        {
            if (this._bodyView)
            {
                this._bodyView.shine(param1);
            }
            return;
        }// end function

        public function unShine() : void
        {
            if (this._bodyView)
            {
                this._bodyView.unShine();
            }
            return;
        }// end function

        public function select() : void
        {
            return;
        }// end function

        public function unSelect() : void
        {
            return;
        }// end function

        public function showTopCue(param1, param2:uint = 16777215, param3:uint = 16, param4:int = 0, param5:int = 0, param6:uint = 2, param7:Number = 1, param8:uint = 100, param9:Number = 0.5, param10:Boolean = false, param11:int = 0, param12:int = 0, param13:int = 1, param14:int = 22, param15:int = 0) : void
        {
            var _loc_16:* = null;
            var _loc_17:* = null;
            if (!this._info)
            {
                return;
            }
            if (!param1)
            {
                return;
            }
            if (!this.scrollMCBuffer)
            {
                this.scrollMCBuffer = new ScrollMCBuffer();
            }
            if (param10)
            {
            }
            else if (this.direct < 0)
            {
                param4 = -param4;
            }
            if (param1 is String)
            {
                _loc_16 = ObjectPool.CheckOut(TextField) as TextField;
                _loc_17 = new TextFormat();
                _loc_17.size = param3;
                _loc_17.color = param2;
                _loc_17.bold = true;
                _loc_16.defaultTextFormat = _loc_17;
                _loc_16.htmlText = "";
                _loc_16.filters = [FrameworkGlobal.BLACK_FILTER];
                _loc_16.autoSize = TextFieldAutoSize.CENTER;
                _loc_16.width = 140;
                _loc_16.x = param4 - _loc_16.width / 2;
                if (this.high > 0)
                {
                    _loc_16.y = -this.high - param5;
                }
                else
                {
                    _loc_16.y = -120 - param5;
                }
                _loc_16.htmlText = param1;
                addChild(_loc_16);
                this.scrollMCBuffer.add(_loc_16, param7, param6, param8, param9);
            }
            else if (param1 is DisplayObject)
            {
                param1.x = param4 - param1.width / 2;
                if (param12 != 0)
                {
                    param1.y = param12;
                }
                else if (this.high > 0)
                {
                    param1.y = -this.high - param5;
                }
                else
                {
                    param1.y = -120 - param5;
                }
                if (param15 == 1)
                {
                    param1.x = param1.x + this.x;
                    param1.y = param1.y + this.y;
                    MapControl.getInstance().addBlood(param1);
                }
                else
                {
                    addChild(param1);
                }
                this.scrollMCBuffer.add(param1, param7, param6, param8, param9, param13, param14, param15);
            }
            return;
        }// end function

        private function finalizeBmpView() : void
        {
            if (this._bodyView)
            {
                this._bodyView.removeEvtListener(Event.COMPLETE, this.__actComplete);
                this._bodyView.filters = [];
                this._bodyView.finalize();
                this._bodyView = null;
            }
            if (this._weaponView)
            {
                this._weaponView.finalize();
                this._weaponView = null;
            }
            if (this._otherWeaponView)
            {
                this._otherWeaponView.finalize();
                this._otherWeaponView = null;
            }
            if (this._horseView)
            {
                this._horseView.finalize();
                this._horseView = null;
            }
            if (this._horseWingView)
            {
                this._horseWingView.finalize();
                this._horseWingView = null;
            }
            if (this._wingView)
            {
                this._wingView.finalize();
                this._wingView = null;
            }
            if (this._otherWingView)
            {
                this._otherWingView.finalize();
                this._otherWingView = null;
            }
            if (this._shadowViewNew)
            {
                this._shadowViewNew.finalize();
                this._shadowViewNew = null;
            }
            if (this._shadowMC && this._shadowMC.parent)
            {
                this._shadowMC.parent.removeChild(this._shadowMC);
                this._shadowMC = null;
            }
            return;
        }// end function

        public function play() : void
        {
            if (this._bodyView)
            {
                this._bodyView.play();
            }
            if (this._weaponView)
            {
                this._weaponView.play();
            }
            if (this._otherWeaponView)
            {
                this._otherWeaponView.play();
            }
            if (this._horseView)
            {
                this._horseView.play();
            }
            if (this._wingView)
            {
                this._wingView.play();
            }
            if (this._otherWingView && this._otherWingView.parent)
            {
                this._otherWingView.play();
            }
            if (this._horseWingView)
            {
                this._horseWingView.play();
            }
            return;
        }// end function

        public function stop() : void
        {
            this._bodyView.stop();
            if (this._weaponView)
            {
                this._weaponView.stop();
            }
            if (this._otherWeaponView)
            {
                this._otherWeaponView.stop();
            }
            if (this._horseView)
            {
                this._horseView.stop();
            }
            if (this._wingView)
            {
                this._wingView.stop();
            }
            if (this._otherWingView)
            {
                this._otherWingView.stop();
            }
            if (this._horseWingView)
            {
                this._horseWingView.stop();
            }
            return;
        }// end function

        public function replay() : void
        {
            this._bodyView.replay();
            if (this._weaponView)
            {
                this._weaponView.replay();
            }
            if (this._otherWeaponView)
            {
                this._otherWeaponView.replay();
            }
            if (this._horseView)
            {
                this._horseView.replay();
            }
            if (this._horseWingView)
            {
                this._horseWingView.replay();
            }
            if (this._wingView)
            {
                this._wingView.replay();
            }
            if (this._otherWingView && this._otherWingView.parent)
            {
                this._otherWingView.replay();
            }
            return;
        }// end function

        public function isEffect() : Boolean
        {
            return this._bodyView && this._bodyView.isEffect();
        }// end function

        public function isUser() : Boolean
        {
            if (this._info && this._info.personId && UserObj.getInstance().playerInfo && UserObj.getInstance().playerInfo.personId)
            {
                return this._info.personId.equal(UserObj.getInstance().playerInfo.personId);
            }
            return false;
        }// end function

        public function isPlayerCutePet() : Boolean
        {
            if (this._info && this._info is CutePetInfo)
            {
                return CutePetInfo(this._info).parentId.equal(UserObj.getInstance().playerInfo.personId);
            }
            return false;
        }// end function

        public function isCutePet() : Boolean
        {
            if (this._info && this._info is CutePetInfo)
            {
                return true;
            }
            return false;
        }// end function

        public function isMagicBook() : Boolean
        {
            if (this._info && this._info is MagicBookInfo)
            {
                return true;
            }
            return false;
        }// end function

        public function isPlayer() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_PLAYER;
            }
            return false;
        }// end function

        public function isNPC() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_NPC;
            }
            return false;
        }// end function

        public function isMonster() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_MONSTER;
            }
            return false;
        }// end function

        public function isCreamMonster() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_MONSTER && this._info.monster_type == MonsterType.MONSTER_CREAM;
            }
            return false;
        }// end function

        public function isBossMonster() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_MONSTER && this._info.monster_type == MonsterType.MONSTER_BOSS;
            }
            return false;
        }// end function

        public function isSummonPet() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_SUMMON_PET;
            }
            return false;
        }// end function

        public function isClientMonster() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_CLIENT_MONSTER;
            }
            return false;
        }// end function

        public function isNotAnyMonster() : Boolean
        {
            if (this._info)
            {
                return this._info.roleType == RoleType.ROLE_TYPE_NOTANY;
            }
            return false;
        }// end function

        override public function finalize() : void
        {
            this.auto = false;
            this.stopSpeak();
            TweenLite.killDelayedCallsTo(this.doShowFake);
            TweenLite.killDelayedCallsTo(this.removeRes);
            this.finalizeBmpView();
            if (this.scrollMCBuffer)
            {
                this.scrollMCBuffer.stop();
            }
            if (this._shadowViewNew)
            {
                this._shadowViewNew.finalize();
            }
            this._info = null;
            super.finalize();
            return;
        }// end function

        public function setIntervalTimes(param1:int) : void
        {
            if (this._bodyView)
            {
                this._bodyView.interval = this._bodyView.interval * param1 / this.curIntervalTime;
            }
            if (this._weaponView)
            {
                this._weaponView.interval = this._weaponView.interval * param1 / this.curIntervalTime;
            }
            if (this._otherWeaponView)
            {
                this._otherWeaponView.interval = this._otherWeaponView.interval * param1 / this.curIntervalTime;
            }
            if (this._horseView)
            {
                this._horseView.interval = this._horseView.interval * param1 / this.curIntervalTime;
            }
            if (this._horseWingView)
            {
                this._horseWingView.interval = this._horseWingView.interval * param1 / this.curIntervalTime;
            }
            if (this._wingView)
            {
                this._wingView.interval = this._wingView.interval * param1 / this.curIntervalTime;
            }
            if (this._otherWingView)
            {
                this._otherWingView.interval = this._otherWingView.interval * param1 / this.curIntervalTime;
            }
            this.curIntervalTime = param1;
            return;
        }// end function

        public function get px() : uint
        {
            return MapUtils.coo2Tile(x);
        }// end function

        public function get py() : uint
        {
            return MapUtils.coo2Tile(y);
        }// end function

        public function get roleIdLow() : uint
        {
            return this._info && this._info.personId ? (this._info.personId.low) : (0);
        }// end function

    }
}
