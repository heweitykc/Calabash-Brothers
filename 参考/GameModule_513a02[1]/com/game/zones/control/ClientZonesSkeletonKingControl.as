package com.game.zones.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.autopk.controller.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.movie.*;
    import com.game.operationpanel.control.*;
    import com.game.player.control.*;
    import com.game.role.*;
    import com.game.task.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class ClientZonesSkeletonKingControl extends Object implements IClientZoneControl
    {
        private var _curRound:int;
        private var _completeResNum:int;
        private var _endCount:int;
        private var moveSceneEndPoint:Point;
        private var moveBeginTime:Number;
        private var moveSceneType:int;
        private var _saturation:Number = 0;
        private var _curDialog:int;
        public const BOSS_MODEL_ID:uint = 410030008;
        public const TOTAL_ROUND:uint = 2;
        private const UP_RES:String = "movie_up.jpg";
        private const DOWN_RES:String = "movie_down";
        private const BOSS_RES:String = "movie_ske_king";
        private const MOVE_SCENE_TIME:Number = 800;
        private const MOVIE_BEGIN_SHOW_TIME:Number = 0.5;
        private const DIALOG_1:int = 100000;
        private const DIALOG_2:int = 100001;
        private const DIALOG_3:int = 100002;
        private const DIALOG_4:int = 100003;
        private const DIALOG_5:int = 100004;
        private const DIALOG_6:int = 100005;
        private var assist:AssistMM;
        public var boss:ClientMonster;
        private var _upImg:Bitmap;
        private var _downImg:Bitmap;
        private var _bossImg:MovieClip;
        private static var _instance:ClientZonesSkeletonKingControl;

        public function ClientZonesSkeletonKingControl()
        {
            return;
        }// end function

        private function showDialog(param1:int) : void
        {
            this._curDialog = param1;
            Global.popManager.addBgMask();
            NpcDialog.getInstance().data = TaskCfgObj.getInstance().getDialogTalkByTeam(this._curDialog);
            NpcDialog.getInstance().addEventListener(Event.COMPLETE, this.__dialogComplete);
            return;
        }// end function

        public function enterZone() : void
        {
            this.curRound = 1;
            RoleList.getInstance().player.stopPath();
            MapClientControl.getInstance().lowestHp = UserObj.getInstance().playerInfo.HPMax * 0.8;
            OperationPanelControl.getInstance().setBarEnable(false);
            PlayerControl.getInstance().setPlayerMainBoxEnable(false);
            MapControl.getInstance().setMiniMapEnable(false);
            Global.popManager.hideAllBox();
            GuideControl.getInstance().hideArrow();
            this.showDialog(this.DIALOG_1);
            return;
        }// end function

        public function exitZone() : void
        {
            var _loc_1:* = RoleList.getInstance().player as Player;
            _loc_1.info.HP = _loc_1.info.HPMax;
            MapControl.getInstance().isClientMove = false;
            MapControl.getInstance().isClientPick = false;
            MapClientControl.getInstance().removeUserAllBuff();
            TaskGlobal.manager.autoFight(false);
            MapClientControl.getInstance().HIT_PLUS = 0;
            OperationPanelControl.getInstance().setBarEnable(true);
            PlayerControl.getInstance().setPlayerMainBoxEnable(true);
            MapControl.getInstance().setMiniMapEnable(true);
            GuideControl.getInstance().unHideArrow();
            this.removeAssistMM();
            return;
        }// end function

        public function nextRound() : void
        {
            (this.curRound + 1);
            return;
        }// end function

        public function get curRound() : int
        {
            return this._curRound;
        }// end function

        public function set curRound(param1:int) : void
        {
            this._curRound = param1;
            if (this._curRound < this.TOTAL_ROUND)
            {
                MapClientControl.getInstance().createClientMonster(MapObj.getInstance().mapID, this.curRound);
            }
            if (this._curRound == this.TOTAL_ROUND)
            {
                this.roundBoss();
            }
            return;
        }// end function

        public function roundOneSpeak() : void
        {
            TaskGlobal.manager.autoFight(false);
            TweenLite.delayedCall(1, this._showRoundOne);
            return;
        }// end function

        private function _showRoundOne() : void
        {
            this.showDialog(this.DIALOG_2);
            return;
        }// end function

        private function __dialogComplete(event:Event) : void
        {
            NpcDialog.getInstance().removeEventListener(Event.COMPLETE, this.__dialogComplete);
            switch(this._curDialog)
            {
                case this.DIALOG_1:
                case this.DIALOG_2:
                {
                    TweenLite.delayedCall(1, this.beginFight);
                    break;
                }
                case this.DIALOG_3:
                {
                    this.agreeHelp();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function beginFight() : void
        {
            Global.popManager.removeBgMask();
            TaskGlobal.manager.autoFight(true);
            return;
        }// end function

        private function roundBoss() : void
        {
            AutoFightController.getInstance().closeAutoFight(true);
            RoleList.getInstance().player.stopPath();
            RoleList.getInstance().player.setAct(Params.ACTION_STAND_ID, true, false);
            TweenLite.delayedCall(this.MOVIE_BEGIN_SHOW_TIME / 10, this.changeFilter);
            Global.popManager.addBgMask();
            TweenLite.delayedCall(1, this.delayMove);
            return;
        }// end function

        private function delayMove() : void
        {
            var _loc_1:* = MapUtils.tile2Coo([59, 29]);
            RoleList.getInstance().player.pathByCoo(_loc_1[0], _loc_1[1]);
            RoleList.getInstance().player.addEvtListener(RoleEvent.ARRIVE, this.roleArrive);
            TweenLite.delayedCall(3, this.createBoss);
            return;
        }// end function

        private function roleArrive(event:RoleEvent = null) : void
        {
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.removeEvtListener(RoleEvent.ARRIVE, this.roleArrive);
            _loc_2.direct = MapUtils.mapDirect2RoleDir(1);
            TweenLite.killDelayedCallsTo(this.createBoss);
            TweenLite.delayedCall(1, this.createBoss);
            return;
        }// end function

        private function createBoss() : void
        {
            TweenLite.killDelayedCallsTo(this.createBoss);
            MapClientControl.getInstance().lowestHp = RoleList.getInstance().player.info.HPMax * 0.5;
            MapClientControl.getInstance().createClientMonster(MapObj.getInstance().mapID, this.curRound);
            this.boss = RoleList.getInstance().getFirstRoleByModelId(this.BOSS_MODEL_ID) as ClientMonster;
            ClientMonsterInfo(this.boss.info).isNeedAutoMove = false;
            this.boss.isAttackSpeak = true;
            this.addHpLis();
            this.boss.moveToAttack(RoleList.getInstance().player, 0, 1, this.bossAttack);
            this.boss.curSkillIndex = 1;
            return;
        }// end function

        private function bossAttack() : void
        {
            var _loc_1:* = RoleList.getInstance().player as Player;
            _loc_1.kickFly(this.boss, 300, false);
            TweenLite.delayedCall(2.5, this.kickFlyComplete);
            return;
        }// end function

        private function kickFlyComplete() : void
        {
            MapClientControl.getInstance().lowestHp = UserObj.getInstance().playerInfo.HPMax * 0.05;
            var _loc_1:* = RoleList.getInstance().player as Player;
            _loc_1.revive();
            this.backFilter();
            this.beginFight();
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this.moveBeginTime;
            var _loc_6:* = _loc_3 / this.MOVE_SCENE_TIME;
            var _loc_7:* = RoleList.getInstance().player as Player;
            if (_loc_3 > this.MOVE_SCENE_TIME || this.moveSceneType == 0)
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
                if (this.moveSceneType == 2)
                {
                    this.sceneBackToUserComplete();
                }
                this.moveSceneType = 0;
            }
            else if (this.moveSceneType == 1)
            {
                _loc_4 = (this.boss.x - _loc_7.x) * _loc_6 + _loc_7.x;
                _loc_5 = (this.boss.y - _loc_7.y) * _loc_6 + _loc_7.y;
                MapControl.getInstance().moveScene(_loc_4, _loc_5);
            }
            else if (this.moveSceneType == 2)
            {
                _loc_4 = (_loc_7.x - this.boss.x) * _loc_6 + this.boss.x;
                _loc_5 = (_loc_7.y - this.boss.y) * _loc_6 + this.boss.y;
                MapControl.getInstance().moveScene(_loc_4, _loc_5);
            }
            return;
        }// end function

        private function _bossShow() : void
        {
            this.boss.attack();
            this.boss.addEventListener(RoleEvent.ACTION_COMPLETE, this._bossShowComplete);
            return;
        }// end function

        private function _bossShowComplete(event:RoleEvent) : void
        {
            this.boss.removeEventListener(RoleEvent.ACTION_COMPLETE, this._bossShowComplete);
            this.boss.auto = false;
            RoleList.getInstance().player.auto = false;
            this._showBossTip();
            return;
        }// end function

        private function _showBossTip() : void
        {
            this.loadTipRes();
            return;
        }// end function

        private function loadTipRes() : void
        {
            VResManager.load("res/zoneskeking.swf", this._resComplete);
            return;
        }// end function

        private function _resComplete(param1:MovieClip) : void
        {
            this._bossImg = ToolKit.getNew(this.BOSS_RES) as MovieClip;
            this._upImg = new Bitmap(ToolKit.getNew(this.DOWN_RES));
            this._upImg.rotationX = 180;
            this._downImg = new Bitmap(ToolKit.getNew(this.DOWN_RES));
            this._beginShowBossBorder();
            return;
        }// end function

        private function _beginShowBossBorder() : void
        {
            this._upImg.y = 0;
            if (this._upImg.width < FrameworkGlobal.stage.stageWidth)
            {
                this._upImg.width = FrameworkGlobal.stage.stageWidth;
            }
            this._upImg.x = -(this._upImg.width - FrameworkGlobal.stage.stageWidth) >> 1;
            this._downImg.y = FrameworkGlobal.stage.stageHeight + this._downImg.height;
            if (this._downImg.width < FrameworkGlobal.stage.stageWidth)
            {
                this._downImg.width = FrameworkGlobal.stage.stageWidth;
            }
            this._downImg.x = -(this._downImg.width - FrameworkGlobal.stage.stageWidth) >> 1;
            FrameworkGlobal.stage.addChild(this._upImg);
            FrameworkGlobal.stage.addChild(this._downImg);
            TweenLite.to(this._upImg, this.MOVIE_BEGIN_SHOW_TIME, {y:this._upImg.height});
            TweenLite.to(this._downImg, this.MOVIE_BEGIN_SHOW_TIME, {y:FrameworkGlobal.stage.stageHeight - this._downImg.height, onComplete:this._beginShowBossTip});
            return;
        }// end function

        private function changeFilter() : void
        {
            var _loc_1:* = new ColorMatrix();
            var _loc_2:* = new ColorMatrixFilter();
            this._saturation = this._saturation - 100 / 10;
            _loc_1.adjustSaturation(this._saturation);
            _loc_2.matrix = _loc_1;
            MapControl.getInstance().addFilterToMap([_loc_2]);
            if (this._saturation > -100)
            {
                TweenLite.delayedCall(this.MOVIE_BEGIN_SHOW_TIME / 5, this.changeFilter);
            }
            return;
        }// end function

        private function _beginShowBossTip(param1 = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = (FrameworkGlobal.stage.stageWidth - this._bossImg.width >> 1) + 60;
            _loc_3 = (FrameworkGlobal.stage.stageHeight - this._bossImg.height >> 1) - 300;
            this._bossImg.alpha = 0.2;
            var _loc_4:* = 1.5;
            this._bossImg.scaleY = 1.5;
            this._bossImg.scaleX = _loc_4;
            this._bossImg.x = (FrameworkGlobal.stage.stageWidth - this._bossImg.width >> 1) + 60;
            this._bossImg.y = (FrameworkGlobal.stage.stageHeight - this._bossImg.height >> 1) - 300;
            FrameworkGlobal.stage.addChild(this._bossImg);
            TweenLite.to(this._bossImg, 0.3, {x:_loc_2, y:_loc_3, scaleX:1, scaleY:1, alpha:1, onComplete:this._showTipComplete});
            return;
        }// end function

        private function _showTipComplete(param1 = null) : void
        {
            TweenLite.delayedCall(0.5, this._beginShowEndTip);
            return;
        }// end function

        private function _beginShowEndTip() : void
        {
            TweenLite.to(this._bossImg, this.MOVIE_BEGIN_SHOW_TIME, {x:-this._bossImg.width, onComplete:this._endTip, onCompleteParams:[this._bossImg]});
            TweenLite.to(this._upImg, this.MOVIE_BEGIN_SHOW_TIME, {y:-this._upImg.height, onComplete:this._endTip, onCompleteParams:[this._upImg]});
            TweenLite.to(this._downImg, this.MOVIE_BEGIN_SHOW_TIME, {y:FrameworkGlobal.stage.stageHeight, onComplete:this._endTip, onCompleteParams:[this._downImg]});
            this.moveSceneType = 2;
            this.moveBeginTime = getTimer();
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._saturation = -100;
            TweenLite.delayedCall(this.MOVIE_BEGIN_SHOW_TIME / 10, this.backFilter);
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
            if (this._saturation < 0)
            {
                TweenLite.delayedCall(this.MOVIE_BEGIN_SHOW_TIME / 5, this.backFilter);
            }
            return;
        }// end function

        private function _endTip(param1) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._endCount + 1;
            _loc_2._endCount = _loc_3;
            FrameworkGlobal.stage.removeChild(param1);
            if (this._endCount == 3)
            {
            }
            return;
        }// end function

        private function sceneBackToUserComplete() : void
        {
            this.boss.auto = true;
            RoleList.getInstance().player.auto = true;
            AutoFightController.getInstance().openAutoFight();
            return;
        }// end function

        private function createAssistMM() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!this.assist)
            {
                _loc_1 = RoleList.getInstance().player as Player;
                this.assist = new AssistMM();
                _loc_2 = new RoleInfo();
                _loc_2.personId = MapClientControl.getInstance().getClientId();
                var _loc_3:* = _loc_1.x + MapUtils.GRID_BORDER * 30;
                _loc_2.x = _loc_1.x + MapUtils.GRID_BORDER * 30;
                this.assist.x = _loc_3;
                var _loc_3:* = _loc_1.y + MapUtils.GRID_BORDER * 30;
                _loc_2.y = _loc_1.y + MapUtils.GRID_BORDER * 30;
                this.assist.y = _loc_3;
                _loc_2.mapId = _loc_2.mapId;
                _loc_2.speed = _loc_2.speed * 1;
                _loc_2.url = "art/res/role/gen/ac007";
                this.assist.info = _loc_2;
                this.assist.direct = MapUtils.mapDirect2RoleDir(7);
                MapControl.getInstance().addSpeciaRole(this.assist);
                this.assist.isFlying = true;
                TweenLite.to(this.assist, 2, {x:_loc_1.x + MapUtils.GRID_BORDER * 4, y:_loc_1.y + MapUtils.GRID_BORDER * 4, onComplete:this.assistMMCreateComplete});
                this.boss.curSkillIndex = 2;
            }
            return;
        }// end function

        private function assistMMCreateComplete() : void
        {
            MapClientControl.getInstance().HIT_PLUS = 2000;
            MapClientControl.getInstance().HIT_RANGE_PLUS = 100;
            this.assist.isFlying = false;
            this.showDialog(this.DIALOG_3);
            return;
        }// end function

        private function agreeHelp() : void
        {
            this.assist.attackToUser();
            TweenLite.delayedCall(1, this.beginFight);
            return;
        }// end function

        private function removeAssistMM() : void
        {
            if (this.assist)
            {
                MapControl.getInstance().removeRoleFromMap(this.assist);
                this.assist.finalize();
                this.assist = null;
            }
            return;
        }// end function

        private function addHpLis() : void
        {
            this.boss.info.addEventListener(RoleEvent.UPDATE_HP, this.__hpChangeHandler);
            var _loc_1:* = RoleList.getInstance().player;
            _loc_1.info.addEventListener(RoleEvent.UPDATE_HP, this.__hpChangeHandler);
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

        private function __hpChangeHandler(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            if (this.boss && this.boss.info && this.boss.info.HP <= this.boss.info.HPMax * 0.05 || _loc_2.info.HP <= _loc_2.info.HPMax * 0.05)
            {
                this.removeHpLis();
                this.bossAngel();
            }
            return;
        }// end function

        private function bossAngel() : void
        {
            this.boss.info.currentSkill = null;
            RoleList.getInstance().player.info.currentSkill = null;
            AutoFightController.getInstance().closeAutoFight(true);
            TweenLite.delayedCall(0.8, this.createAssistMM);
            return;
        }// end function

        private function bossAngelAttack() : void
        {
            this.boss.moveToAttack(RoleList.getInstance().player, 1, 1);
            this.boss.curSkillIndex = 2;
            MapClientControl.getInstance().lowestHp = UserObj.getInstance().playerInfo.HPMax * 0.05;
            return;
        }// end function

        private function continueFight() : void
        {
            AutoFightController.getInstance().openAutoFight();
            return;
        }// end function

        public function lastAttack() : void
        {
            FrameworkGlobal.GLOBAL_BMP_MULTIPLE = 4;
            TweenLite.delayedCall(3, this.endLastAttack);
            return;
        }// end function

        private function endLastAttack() : void
        {
            FrameworkGlobal.GLOBAL_BMP_MULTIPLE = 1;
            this.assist.info.currentSkill = null;
            TweenLite.delayedCall(3, this.delayCreateFakePass);
            return;
        }// end function

        private function delayCreateFakePass() : void
        {
            AutoFightController.getInstance().closeAutoFight(true);
            MapClientControl.getInstance().createFakePassRes();
            return;
        }// end function

        public static function getInstance() : ClientZonesSkeletonKingControl
        {
            if (!_instance)
            {
                _instance = new ClientZonesSkeletonKingControl;
            }
            return _instance;
        }// end function

    }
}
