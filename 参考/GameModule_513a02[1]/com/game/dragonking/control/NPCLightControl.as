package com.game.dragonking.control
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.dragonking.*;
    import com.game.dragonking.model.*;
    import com.game.map.control.*;
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
    import flash.utils.*;

    public class NPCLightControl extends Object implements IPhaseControl
    {
        private var _npc:Role;
        private var _frontView:VMCView;
        private var _equipArr:Array;
        private var _glowerFilter:GlowFilter;
        private var _fallview:VMCView;
        private var _npcPosX:int;
        private var _npcPosY:int;
        private var player:Player;
        private var _tips:Sprite;
        private var _backView:VMCView;
        private var _frameCount:int;
        private var _lastTime:uint;
        private var _start:int;
        private var _end:int;
        private var _dragonView:VMCView;

        public function NPCLightControl()
        {
            this._equipArr = [[310019, 500015, 413007], [320009, 320025, 500016, 423005], [330015, 500017, 433006]];
            return;
        }// end function

        public function start() : void
        {
            MapControl.getInstance().setPlayerOperatable(false);
            this.player = RoleList.getInstance().player as Player;
            var _loc_1:* = MapUtils.tile2Coo([39, 26]);
            this._npcPosX = _loc_1[0];
            this._npcPosY = _loc_1[1];
            TweenLite.delayedCall(5, this.endNPC);
            TweenLite.delayedCall(1.3, this.createNPC);
            TweenLite.delayedCall(1, this.playFallDown);
            TweenLite.delayedCall(2.2, this.speakFirst);
            TweenLite.delayedCall(5, this.speakSec);
            TweenLite.delayedCall(9.7, this.speakThird);
            TweenLite.delayedCall(10.2, this.disappearNPC);
            TweenLite.delayedCall(12.4, DragonKingController.getInstance().zoneDialogEnd);
            return;
        }// end function

        private function playFallDown() : void
        {
            this._fallview = new VMCView();
            this._fallview.auto = true;
            this._fallview.url = "res/effect/falldown.png";
            this._fallview.updatePose("90", false);
            this._fallview.move(this._npcPosX, this._npcPosY);
            MapControl.getInstance().currentGameScene.topLayer.addChild(this._fallview);
            return;
        }// end function

        private function endNPC() : void
        {
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__enterframe, false, 0, true);
            this._frameCount = 0;
            this._glowerFilter = new GlowFilter(16777150, 1, 0, 0, 2.5);
            var _loc_1:* = RoleList.getInstance().player as Player;
            (_loc_1).bodyView.filters = [this._glowerFilter];
            this._lastTime = getTimer();
            return;
        }// end function

        private function speakFirst() : void
        {
            DragonKingController.getInstance().say(LanguageCfgObj.getInstance().getByIndex("10601"), null, this._npc.info, true);
            return;
        }// end function

        private function speakSec() : void
        {
            DragonKingController.getInstance().say(LanguageCfgObj.getInstance().getByIndex("10602"), null, this._npc.info);
            return;
        }// end function

        private function speakThird() : void
        {
            DragonKingController.getInstance().say(LanguageCfgObj.getInstance().getByIndex("10603"), null, this._npc.info);
            return;
        }// end function

        private function __enterframe(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = getTimer();
            if (_loc_2 - this._lastTime > 83)
            {
                var _loc_4:* = this;
                var _loc_5:* = this._frameCount + 1;
                _loc_4._frameCount = _loc_5;
                if (this._frameCount == 1)
                {
                    this._frontView = new VMCView();
                    this._frontView.auto = true;
                    this._frontView.updatePose("front_90", false, false, true);
                    this._frontView.loadRes("res/effect/transform.png");
                    this._backView = new VMCView();
                    this._backView.auto = true;
                    this._backView.updatePose("back_90", false, false, true);
                    this._backView.loadRes("res/effect/transform.png");
                    RoleList.getInstance().player.getSprite().addChild(this._frontView);
                    RoleList.getInstance().player.getSprite().addChild(this._backView);
                }
                if (this._frameCount < 10)
                {
                    this._glowerFilter.blurX = this._glowerFilter.blurX + 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY + 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount == 20)
                {
                    RoleList.getInstance().player.visible = false;
                    this._frontView.finalize();
                    this._backView.finalize();
                }
                else if (this._frameCount == 22)
                {
                    RoleList.getInstance().player.visible = true;
                    this.updateAttribute();
                    this._glowerFilter.blurX = this._glowerFilter.blurX - 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY - 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount > 21 && this._frameCount < 31)
                {
                    this._glowerFilter.blurX = this._glowerFilter.blurX - 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY - 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount == 31)
                {
                    FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__enterframe);
                    (RoleList.getInstance().player as Player).bodyView.filters = [];
                    TweenLite.delayedCall(2, this.end);
                }
                if (this._frameCount == 24)
                {
                    this._tips = ToolKit.getNew("dragonkingskilltips");
                    _loc_3 = OperationPanelControl.getInstance().getSkillGridEmpty(null);
                    DragonKingModel.getInstance().skillboxid = _loc_3.gridId;
                    MapClientControl.getInstance().addClientSkill(DragonKingModel.getInstance().SKILL_ARRAY[(UserObj.getInstance().playerInfo.job - 1) % 3], _loc_3.gridId);
                    DragonKingController.getInstance().prefightNumber = UserObj.getInstance().playerInfo.fightPower;
                    DragonKingController.getInstance().attackspeed = UserObj.getInstance().playerInfo.attackspeed;
                    UserObj.getInstance().playerInfo.fightPower = 9999;
                    UserObj.getInstance().playerInfo.attackspeed = UserObj.getInstance().playerInfo.attackspeed + 30;
                }
                this._lastTime = _loc_2;
            }
            return;
        }// end function

        private function disappearNPC() : void
        {
            this._fallview.updatePose("90", false);
            this._fallview.replay();
            TweenLite.delayedCall(0.2, this.npcDisappear);
            return;
        }// end function

        private function npcDisappear() : void
        {
            if (this._npc)
            {
                MapControl.getInstance().removeRoleFromMap(this._npc);
            }
            return;
        }// end function

        public function changeEquip() : void
        {
            TweenLite.delayedCall(0.3, this.updateAttribute);
            return;
        }// end function

        public function updateAttribute() : void
        {
            var _loc_1:* = this._equipArr[(UserObj.getInstance().playerInfo.job - 1) % 3];
            if (_loc_1.length == 4)
            {
                MapClientControl.getInstance().addWeapon(_loc_1.shift(), 1);
                MapClientControl.getInstance().addWeapon(_loc_1.shift(), 2);
            }
            else if (_loc_1.length == 3)
            {
                MapClientControl.getInstance().addWeapon(_loc_1.shift(), 1);
                MapClientControl.getInstance().removeWeapon(2);
            }
            MapClientControl.getInstance().addWing(_loc_1.shift(), Params.WING);
            MapClientControl.getInstance().addArmor(_loc_1.shift());
            return;
        }// end function

        private function showDragon() : void
        {
            this._dragonView = new VMCView();
            this._dragonView.updatePose("90", true);
            MapControl.getInstance().currentGameScene.topLayer.addChild(this._dragonView);
            this._dragonView.addEvtListener(Event.COMPLETE, this.__dragonShow);
            this.end();
            return;
        }// end function

        private function __dragonShow(event:Event) : void
        {
            return;
        }// end function

        public function createNPC() : void
        {
            this._npc = new Role();
            var _loc_1:* = new RoleInfo();
            var _loc_2:* = NpcCfgObj.getInstance().getNpcByID("309001");
            _loc_1.personId = MapClientControl.getInstance().getClientId();
            var _loc_3:* = MapUtils.tile2Coo([39, 26]);
            var _loc_4:* = _loc_3[0];
            _loc_1.x = _loc_3[0];
            this._npc.x = _loc_4;
            var _loc_4:* = _loc_3[1];
            _loc_1.y = _loc_3[1];
            this._npc.y = _loc_4;
            _loc_1.mapId = _loc_1.mapId;
            _loc_1.speed = _loc_1.speed * 1;
            _loc_1.name = _loc_2._npcName;
            _loc_1.showID = _loc_2._npcRes;
            _loc_1.q_head = _loc_2.q_head;
            _loc_1.roleType = RoleType.ROLE_TYPE_NPC;
            this._npc.info = _loc_1;
            this.player.face2(this._npc.x, this._npc.y);
            this._npc.face2(this.player.x, this.player.y);
            MapControl.getInstance().addSpeciaRole(this._npc);
            return;
        }// end function

        private function stop() : void
        {
            if (this._npc)
            {
                this._npc.stopSpeak();
            }
            return;
        }// end function

        public function end() : void
        {
            TweenLite.killDelayedCallsTo(this.end);
            DragonKingController.getInstance().nextRound();
            return;
        }// end function

    }
}
