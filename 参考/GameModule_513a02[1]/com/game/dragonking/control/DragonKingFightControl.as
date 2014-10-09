package com.game.dragonking.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.autopk.controller.*;
    import com.game.dragonking.*;
    import com.game.dragonking.model.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.operationpanel.control.*;
    import com.game.operationpanel.view.*;
    import com.game.role.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class DragonKingFightControl extends Object implements IPhaseControl
    {
        private var _lightView:VMCView;
        private var _player:Player;
        public var deadComplete:Boolean;
        private const MOVIE_BEGIN_SHOW_TIME:Number = 1;
        private var _targetArr:Array;
        private var stPosition:Array;
        private var distanceTime:int;
        private var stTime:int;
        private var distanceX:int;
        private var distanceY:int;
        private var boss:ClientMonster;
        public const BOSS_MODEL_ID:uint = 330050006;
        private var _tips:Sprite;
        private var bossInfo:ClientMonsterInfo;
        private var _deadView:VMCView;
        private var _curTime:int;
        private var _lastTime:int = 500;
        private var _scale:Number = 1.2;
        private var _baseArr:Array;
        private var _count:int;
        private var _drop:VMCView;
        private var _dropIcon:DropIcon;
        private var _glowerFilter:GlowFilter;
        private var angle:int;
        private var _frameCount:int;
        private var _flashView:VMCView;
        private var _ballSp:Sprite;
        private var _ballView:VMCView;
        private var count:int;
        private var _successView:VMCView;
        private var _saturation:Number = 0;
        private static var _inst:DragonKingFightControl;

        public function DragonKingFightControl()
        {
            return;
        }// end function

        public function start() : void
        {
            TweenLite.delayedCall(1.5, this.light);
            this._player = RoleList.getInstance().player as Player;
            MapControl.getInstance().setPlayerOperatable(false);
            return;
        }// end function

        private function light() : void
        {
            this.boss = new ClientMonster();
            var _loc_1:* = new RoleInfo();
            this._lightView = new VMCView();
            var _loc_2:* = MapControl.getInstance().currentGameScene.getMapXY(MapControl.getInstance().currentGameScene._w, 0);
            var _loc_3:* = MapCfgObj.getInstance().getClientMonsterByMapId(MapObj.getInstance().mapID);
            this._targetArr = [_loc_3[1][0].x, _loc_3[1][0].y];
            var _loc_4:* = _loc_3[1][0];
            _loc_4.personId = MapClientControl.getInstance().getClientId();
            this.distanceX = _loc_4.x - _loc_2[0];
            this.distanceY = _loc_4.y - _loc_2[1];
            _loc_4.isNeedAutoMove = false;
            _loc_4.x = _loc_2[0];
            _loc_4.y = _loc_2[1];
            this.boss.info = _loc_4;
            this.stPosition = [_loc_2[0], _loc_2[1]];
            this.stTime = getTimer();
            this.distanceTime = ToolKit.distance(this.stPosition[0], this.stPosition[1], this._targetArr[0], this._targetArr[1]) * 1000 / _loc_4.speed;
            MapControl.getInstance().addClientMonsterByInfo(_loc_4);
            this.boss = RoleList.getInstance().getFirstRoleByModelId(this.BOSS_MODEL_ID) as ClientMonster;
            this.boss.addEvtListener(Event.ENTER_FRAME, this.dragonkingIn);
            MapControl.getInstance().addSpeciaRole(this.boss);
            this.boss.fly = true;
            this.boss.setAct(Params.ACTION_FLY, true);
            return;
        }// end function

        private function dragonkingIn(event:Event) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this.stTime;
            var _loc_4:* = this.distanceTime - _loc_3;
            var _loc_5:* = RoleList.getInstance().player as Player;
            if (RoleList.getInstance().player as Player)
            {
                _loc_5.face2(this.boss.x, this.boss.y);
            }
            if (_loc_4 > 0)
            {
                _loc_6 = (_loc_2 - this.stTime) / this.distanceTime;
                _loc_7 = ToolKit.getAngle(this.boss.x, this.boss.y, this._targetArr[0], this._targetArr[1]);
                if (_loc_7 > 337 || _loc_7 < 23)
                {
                    _loc_8 = FrameworkGlobal.DIRECT_90;
                }
                else if (_loc_7 > 292)
                {
                    _loc_8 = FrameworkGlobal.DIRECT_45;
                }
                else if (_loc_7 > 247)
                {
                    _loc_8 = FrameworkGlobal.DIRECT_0;
                }
                else if (_loc_7 > 202)
                {
                    _loc_8 = -FrameworkGlobal.DIRECT_45;
                }
                else if (_loc_7 > 157)
                {
                    _loc_8 = -FrameworkGlobal.DIRECT_90;
                }
                else if (_loc_7 > 112)
                {
                    _loc_8 = -FrameworkGlobal.DIRECT_135;
                }
                else if (_loc_7 > 67)
                {
                    _loc_8 = FrameworkGlobal.DIRECT_180;
                }
                else
                {
                    _loc_8 = FrameworkGlobal.DIRECT_135;
                }
                if (this.boss.direct != _loc_8)
                {
                    this.boss.direct = _loc_8;
                }
                this.boss.checkAlpha();
                this.boss.move(this.stPosition[0] + this.distanceX * _loc_6, this.stPosition[1] + this.distanceY * _loc_6);
            }
            else
            {
                this.boss.face2(this._player.x, this._player.y);
                this.boss.checkAlpha();
                this.boss.removeEvtListener(Event.ENTER_FRAME, this.dragonkingIn);
                this.createBoss();
            }
            return;
        }// end function

        public function end() : void
        {
            DragonKingController.getInstance().nextRound();
            return;
        }// end function

        public function createBoss() : void
        {
            Global.popManager.removeBgMask();
            MapClientControl.getInstance().lowestHp = RoleList.getInstance().player.info.HPMax * 0.5;
            this.bossInfo = this.boss.info as ClientMonsterInfo;
            ClientMonsterInfo(this.boss.info).isNeedAutoMove = false;
            this.createSkillTips();
            this.boss.isAttackSpeak = true;
            this.addHpLis();
            if (this.boss)
            {
                this.boss.curSkillIndex = 1;
                this.boss.currentSkill = 0;
            }
            return;
        }// end function

        private function createSkillTips() : void
        {
            this._tips = ToolKit.getNew("dragonkingskilltips");
            var _loc_1:* = OperationPanelControl.getInstance().getSkillGrid(DragonKingModel.getInstance().skillboxid);
            (this._tips.getChildByName("txt") as TextField).htmlText = LanguageCfgObj.getInstance().getByIndex("11973");
            ButtonFlickerControl.getInstance().addButtonFlicker(this._tips);
            TweenLite.delayedCall(10, this.tipsComplete);
            if (_loc_1.parent)
            {
                this._tips.x = _loc_1.x + (_loc_1.width - this._tips.width) * 0.5;
                this._tips.y = _loc_1.y - this._tips.height;
                _loc_1.parent.addChild(this._tips);
            }
            return;
        }// end function

        private function tipsComplete() : void
        {
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._tips);
            if (this._tips.parent)
            {
                this._tips.parent.removeChild(this._tips);
            }
            return;
        }// end function

        public function dealDead() : void
        {
            this.boss.info.currentSkill = null;
            RoleList.getInstance().player.info.currentSkill = null;
            AutoFightController.getInstance().closeAutoFight(true);
            this._curTime = getTimer();
            this._targetArr = MapUtils.tile2Coo([this.boss.px, this.boss.py]);
            var _loc_1:* = RoleList.getInstance().player;
            this._baseArr = MapUtils.tile2Coo([_loc_1.px, _loc_1.py]);
            FrameworkGlobal.GLOBAL_BMP_MULTIPLE = 5;
            this._deadView = new VMCView();
            this._deadView.auto = true;
            this._deadView.updatePose("90", false);
            this._deadView.loadRes("res/effect/dragonkingdead.png");
            this.boss.addChild(this._deadView);
            this.backFilter();
            TweenLite.delayedCall(3.5, this.createDrop);
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__moveZone);
            MapControl.getInstance().setPlayerOperatable(false);
            return;
        }// end function

        private function returnBack() : void
        {
            var _loc_2:* = null;
            this._curTime = getTimer();
            var _loc_1:* = RoleList.getInstance().player;
            _loc_2 = this._baseArr;
            this._baseArr = this._targetArr;
            this._targetArr = _loc_2;
            this._scale = 1;
            this.deadComplete = true;
            this._lastTime = 1000;
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__moveZone);
            return;
        }// end function

        private function __moveZone(event:Event) : void
        {
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this._curTime;
            if (_loc_3 > this._lastTime)
            {
                var _loc_6:* = this;
                var _loc_7:* = this._count + 1;
                _loc_6._count = _loc_7;
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__moveZone);
                if (this._count < 2)
                {
                    TweenLite.delayedCall(2, this.returnBack);
                }
                else
                {
                    this.deadComplete = true;
                    FrameworkGlobal.GLOBAL_BMP_MULTIPLE = 1;
                }
                return;
            }
            var _loc_4:* = _loc_3 / this._lastTime;
            var _loc_5:* = (this._scale - MapControl.getInstance().currentGameScene.scaleX) * _loc_4 + MapControl.getInstance().currentGameScene.scaleX;
            MapControl.getInstance().currentGameScene.setScale(_loc_5);
            MapControl.getInstance().currentGameScene.setScale(_loc_5);
            MapControl.getInstance().moveScene(this._player.x * _loc_5, this._player.y * _loc_5);
            return;
        }// end function

        public function dealDrop(param1:DropIcon) : void
        {
            this._glowerFilter = new GlowFilter(16777150, 1, 0, 0, 2.5);
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__enterframe, false, 0, true);
            this._dropIcon = param1;
            this._dropIcon.filters = [this._glowerFilter];
            return;
        }// end function

        private function __enterframe(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._curTime > 20)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._frameCount + 1;
                _loc_3._frameCount = _loc_4;
                this._curTime = _loc_2;
                if (this._frameCount == 1)
                {
                }
                if (this._frameCount < 10)
                {
                    this._glowerFilter.blurX = this._glowerFilter.blurX + 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY + 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount < 40)
                {
                }
                else if (this._frameCount < 75)
                {
                    if (this._dropIcon.scaleX > 0.05)
                    {
                        this._dropIcon.scaleX = this._dropIcon.scaleX - 0.08;
                        this._dropIcon.scaleY = this._dropIcon.scaleY - 0.08;
                    }
                }
                else if (this._frameCount == 75)
                {
                    FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__enterframe, false);
                    this._ballView = new VMCView();
                    this._ballView.auto = true;
                    this._ballView.updatePose("90", true);
                    this._ballView.loadRes("res/effect/releasefrontres.png");
                    this._ballSp = new Sprite();
                    this._ballSp.addChild(this._ballView);
                    this._ballSp.x = this._dropIcon.x;
                    this._ballSp.y = this._dropIcon.y;
                    this._dropIcon.parent.addChild(this._ballSp);
                    if (this._dropIcon.parent)
                    {
                        this._dropIcon.parent.removeChild(this._dropIcon);
                    }
                    FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__round, false, 0, true);
                    this._lastTime = 2000;
                    this._curTime = getTimer();
                    this._targetArr = [this._dropIcon.x, this._dropIcon.y - 150];
                }
            }
            return;
        }// end function

        private function __round(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this._curTime;
            var _loc_6:* = (_loc_2 - this._curTime) / this._lastTime;
            var _loc_7:* = this._ballSp.x;
            var _loc_8:* = this._ballSp.y;
            if (_loc_3 <= this._lastTime - 200)
            {
                _loc_4 = (this._targetArr[0] - _loc_7) * _loc_6 + _loc_7;
                _loc_5 = (this._targetArr[1] - _loc_8) * _loc_6 + _loc_8;
                this._ballSp.x = _loc_4;
                this._ballSp.y = _loc_5;
            }
            else
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__round, false);
                this._lastTime = 2000;
                this._curTime = getTimer();
                this._targetArr = [this._player.x, this._player.y - this._player.height * 0.25];
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__roundBack, false, 0, true);
            }
            return;
        }// end function

        private function __roundBack(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this._curTime;
            var _loc_6:* = (_loc_2 - this._curTime) / this._lastTime;
            if (_loc_3 <= this._lastTime - 200)
            {
                _loc_4 = this._targetArr[0] - (this._targetArr[0] - this._ballSp.x) * (1 - _loc_6);
                _loc_5 = this._targetArr[1] - (this._targetArr[1] - this._ballSp.y) * (1 - _loc_6);
                this._ballSp.x = _loc_4;
                this._ballSp.y = _loc_5;
            }
            else
            {
                this._ballView.finalize();
                this._successView = new VMCView();
                this._successView.auto = true;
                this._successView.updatePose("90", false);
                this._successView.loadRes("res/effect/getweapon.png");
                this._player.getSprite().addChild(this._successView);
                TweenLite.delayedCall(3.5, this.weaponGetSuc);
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__roundBack, false);
            }
            return;
        }// end function

        private function weaponGetSuc() : void
        {
            this._successView.finalize();
            this.end();
            return;
        }// end function

        public function createDrop() : void
        {
            var _loc_1:* = [700154, 700155, 700156];
            var _loc_2:* = [];
            _loc_2.push(_loc_1[(UserObj.getInstance().playerInfo.job - 1) % 3]);
            MapClientControl.getInstance().createMonDrop(_loc_2, this.bossInfo.moneyDrop, this.boss.x, this.boss.y);
            return;
        }// end function

        private function addHpLis() : void
        {
            this.boss.info.addEventListener(RoleEvent.UPDATE_HP, this.__hpChangeHandler);
            var _loc_1:* = RoleList.getInstance().player;
            _loc_1.info.addEventListener(RoleEvent.UPDATE_HP, this.__hpChangeHandler);
            return;
        }// end function

        private function __hpChangeHandler(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            if (this.boss && this.boss.info && this.boss.info.HP <= this.boss.info.HPMax * 0.05 || _loc_2.info.HP <= _loc_2.info.HPMax * 0.05)
            {
                this.removeHpLis();
            }
            return;
        }// end function

        private function removeHpLis() : void
        {
            if (this.boss && this.boss.info)
            {
                this.boss.info.removeEventListener(RoleEvent.UPDATE_HP, this.__hpChangeHandler);
            }
            var _loc_1:* = RoleList.getInstance().player;
            _loc_1.info.removeEventListener(RoleEvent.UPDATE_HP, this.__hpChangeHandler);
            return;
        }// end function

        private function bossAttack() : void
        {
            var _loc_1:* = RoleList.getInstance().player as Player;
            TweenLite.delayedCall(2.5, this.kickFlyComplete);
            return;
        }// end function

        private function kickFlyComplete() : void
        {
            MapClientControl.getInstance().lowestHp = UserObj.getInstance().playerInfo.HPMax * 0.05;
            var _loc_1:* = RoleList.getInstance().player as Player;
            _loc_1.revive();
            this.beginFight();
            return;
        }// end function

        private function backFilter() : void
        {
            var _loc_1:* = new ColorMatrix();
            var _loc_2:* = new ColorMatrixFilter();
            this._saturation = this._saturation + 100 / 10;
            _loc_1.adjustSaturation(this._saturation);
            _loc_2.matrix = _loc_1;
            MapControl.getInstance().addFilterToMap([_loc_2]);
            return;
        }// end function

        private function beginFight() : void
        {
            Global.popManager.removeBgMask();
            return;
        }// end function

        private function bossAngel() : void
        {
            this.boss.info.currentSkill = null;
            RoleList.getInstance().player.info.currentSkill = null;
            AutoFightController.getInstance().closeAutoFight(true);
            return;
        }// end function

        public static function getInstance() : DragonKingFightControl
        {
            var _loc_1:* = new DragonKingFightControl;
            _inst = new DragonKingFightControl;
            return _inst || _loc_1;
        }// end function

    }
}
