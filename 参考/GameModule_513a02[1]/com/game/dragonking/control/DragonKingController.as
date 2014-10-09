package com.game.dragonking.control
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.autopk.controller.*;
    import com.game.dragonking.model.*;
    import com.game.dragonking.view.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.operationpanel.control.*;
    import com.game.player.control.*;
    import com.game.player.model.*;
    import com.game.role.*;
    import com.game.task.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class DragonKingController extends Object implements IClientZoneControl
    {
        private var _model:DragonKingModel;
        private var _falldownControl:FallDownControl;
        private var _prefightNumber:int;
        private var _attackspeed:int;
        private var _fightControl:DragonKingFightControl;
        private var _dialog:ZoneDialog;
        private const resArr:Array;
        private var _resComplete:Boolean;
        private var _transView:VMCView;
        private var _npclightControl:NPCLightControl;
        private var _flashControl:FlashControl;
        private static var _inst:DragonKingController;

        public function DragonKingController()
        {
            this._model = DragonKingModel.getInstance();
            this.resArr = ["res/effect/falldown.png", "res/effect/transform.png", "res/effect/weaponget.png"];
            return;
        }// end function

        public function get attackspeed() : int
        {
            return this._attackspeed;
        }// end function

        public function set attackspeed(param1:int) : void
        {
            this._attackspeed = param1;
            return;
        }// end function

        public function get prefightNumber() : int
        {
            return this._prefightNumber;
        }// end function

        public function set prefightNumber(param1:int) : void
        {
            this._prefightNumber = param1;
            return;
        }// end function

        public function enterZone() : void
        {
            RoleList.getInstance().player.stopPath();
            MapClientControl.getInstance().lowestHp = UserObj.getInstance().playerInfo.HPMax * 0.8;
            OperationPanelControl.getInstance().setBarEnable(false);
            PlayerControl.getInstance().setPlayerMainBoxEnable(false);
            MapControl.getInstance().setMiniMapEnable(false);
            if (UserObj.getInstance().playerInfo.horseInfo != null)
            {
                MapClientControl.getInstance().changeRideState();
            }
            AutoFightController.getInstance().closeAutoFight(true);
            Global.popManager.hideAllBox();
            GuideControl.getInstance().hideArrow();
            Global.popManager.removeBgMask();
            this._model.curPhase = 1;
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
            if (DragonKingModel.getInstance().skillboxid != 0)
            {
                MapClientControl.getInstance().removeClientSkill(DragonKingModel.getInstance().skillboxid);
                DragonKingModel.getInstance().skillboxid = 0;
            }
            this.equipBack();
            return;
        }// end function

        public function onResComplete() : void
        {
            if (!this._resComplete)
            {
                this.curRound = 1;
                this._resComplete = true;
            }
            return;
        }// end function

        public function say(param1:String, param2:RoleInfo = null, param3:RoleInfo = null, param4:Boolean = false) : void
        {
            if (this._dialog == null)
            {
                this._dialog = new ZoneDialog();
            }
            var _loc_5:* = new Object();
            if (param2)
            {
                _loc_5.name = param2.name;
            }
            if (param3)
            {
                _loc_5.name = param3.name;
            }
            _loc_5.content = param1;
            if (param2)
            {
                _loc_5.left = Params.ART_PATH + "half/" + param2.q_head + ".png";
            }
            if (param3)
            {
                _loc_5.right = Params.ART_PATH + "half/" + param3.q_head + ".png";
            }
            this._dialog.beginShow(_loc_5, param4);
            FrameworkGlobal.stage.addChild(this._dialog);
            return;
        }// end function

        public function zoneDialogEnd() : void
        {
            if (this._dialog != null)
            {
                this._dialog.end();
            }
            return;
        }// end function

        public function nextRound() : void
        {
            (this.curRound + 1);
            return;
        }// end function

        private function equipBack() : void
        {
            var _loc_1:* = EquipsObj.getInstance().getEquipBy(Params.LEFT_WEAPON);
            var _loc_2:* = EquipsObj.getInstance().getEquipBy(Params.RIGHT_WEAPON);
            var _loc_3:* = EquipsObj.getInstance().getEquipBy(Params.WING);
            var _loc_4:* = EquipsObj.getInstance().getEquipBy(Params.BODY);
            MapClientControl.getInstance().addWeapon(_loc_1.itemModelId, 1, _loc_1.intensify);
            MapClientControl.getInstance().addWeapon(_loc_2.itemModelId, 2, _loc_2.intensify);
            MapClientControl.getInstance().addArmor(_loc_4.itemModelId, Params.BODY, _loc_4.intensify);
            MapClientControl.getInstance().addWing(_loc_3.itemModelId, Params.WING, _loc_3.intensify);
            return;
        }// end function

        public function get curRound() : int
        {
            return DragonKingModel.getInstance().curPhase;
        }// end function

        public function set curRound(param1:int) : void
        {
            this._model.curPhase = param1;
            this.doPhase();
            return;
        }// end function

        public function moveToTransfer() : void
        {
            var transfer:RoleInfo;
            transfer = new RoleInfo();
            var player:* = RoleList.getInstance().player as Player;
            if (player)
            {
                MapControl.getInstance().setPlayerOperatable(false);
                transfer.x = player.x + MapUtils.GRID_BORDER * 7;
                transfer.y = player.y - MapUtils.GRID_BORDER * 5;
                this._transView = new VMCView();
                this._transView.loadRes("res/effect/door.png", null, false, function () : void
            {
                MapControl.getInstance().addClientTransfer(_transView);
                TweenLite.delayedCall(4, effectComplete, [transfer.x + 20, transfer.y + 80]);
                return;
            }// end function
            );
                this._transView.auto = true;
                this._transView.direct = 5;
                this._transView.updatePose("90", false);
                this._transView.move(transfer.x, transfer.y);
            }
            return;
        }// end function

        private function effectComplete(param1:int, param2:int) : void
        {
            var _loc_3:* = RoleList.getInstance().player as Player;
            if (_loc_3)
            {
                _loc_3.pathByCoo(param1, param2);
                _loc_3.addEvtListener(RoleEvent.ARRIVE, this.__enterZone);
            }
            return;
        }// end function

        private function __enterZone(event:RoleEvent) : void
        {
            if (this._transView)
            {
                if (this._transView.parent)
                {
                    this._transView.parent.removeChild(this._transView);
                }
                this._transView.finalize();
            }
            var _loc_2:* = RoleList.getInstance().player as Player;
            if (_loc_2)
            {
                _loc_2.removeEvtListener(RoleEvent.ARRIVE, this.__enterZone);
            }
            MapClientControl.getInstance().clientChangeMap(Params.CLIENT_ZONES_DRAGON_KING);
            return;
        }// end function

        public function doPhase() : void
        {
            switch(this._model.curPhase)
            {
                case 1:
                {
                    this._falldownControl = new FallDownControl();
                    this._falldownControl.start();
                    break;
                }
                case 2:
                {
                    this._npclightControl = new NPCLightControl();
                    this._npclightControl.start();
                    break;
                }
                case 3:
                {
                    this._fightControl = DragonKingFightControl.getInstance();
                    this._fightControl.start();
                    break;
                }
                case 4:
                {
                    this._flashControl = new FlashControl();
                    this._flashControl.start();
                    break;
                }
                case 5:
                {
                    this.endPhase();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function endPhase() : void
        {
            UserObj.getInstance().playerInfo.fightPower = this._prefightNumber;
            UserObj.getInstance().playerInfo.attackspeed = this._attackspeed;
            MapClientControl.getInstance().clientBackMap();
            Global.popManager.removeBgMask();
            TweenLite.delayedCall(0.5, this.removeBg);
            return;
        }// end function

        private function removeBg() : void
        {
            if (this._flashControl)
            {
                this._flashControl.removeBg();
            }
            return;
        }// end function

        public static function getInstance() : DragonKingController
        {
            var _loc_1:* = new DragonKingController;
            _inst = new DragonKingController;
            return _inst || _loc_1;
        }// end function

    }
}
