package com.game.xscb.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.fight.control.*;
    import com.game.map.control.*;
    import com.game.role.*;
    import com.game.role.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.game.xscb.model.*;
    import com.game.xscb.view.*;
    import com.game.zones.control.*;
    import com.game.zones.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class ScarletHoldControl extends Object
    {
        private var _model:ScarletHoldModel;
        private var _isHangUp:Boolean;
        private var _scene:ScarletHoldGameScene;
        private var _clientMonst:Role;
        private var _start:Boolean;
        private var _startPoint:Point;
        private var _points:Array;
        private const POINT_MONST:Array;
        private var hangUpPoint:Array;
        private var _saveX:int;
        private var _saveY:int;
        private var _confirmStartId:int;
        private var _startConfirmTime:int;
        private var _timeCount:int;
        private var _timeId:String;
        private var zonemonsters:Array;
        public static const SAFE_TIME:int = 10;
        private static var _inst:ScarletHoldControl;
        public static const MONSTID:int = 888;

        public function ScarletHoldControl()
        {
            this._startPoint = new Point(83, 103);
            this._points = [];
            this.POINT_MONST = [{x:96, y:95}, {x:109, y:88}, {x:119, y:83}, {x:129, y:78}, {x:138, y:73}, {x:147, y:69}];
            this.zonemonsters = [130021006, 130022006, 130023006, 130024006, 130025006, 130026006, 130027006, 130028006];
            this._model = ScarletHoldModel.getInstance();
            return;
        }// end function

        public function get isHangUp() : Boolean
        {
            return this._isHangUp;
        }// end function

        public function set isHangUp(param1:Boolean) : void
        {
            this._isHangUp = param1;
            if (this.isHangUp)
            {
                Global.usePointSeek = true;
            }
            else
            {
                Global.usePointSeek = false;
                clearInterval(this._confirmStartId);
            }
            this.hang();
            return;
        }// end function

        public function get scene() : ScarletHoldGameScene
        {
            return this._scene;
        }// end function

        public function set scene(param1:ScarletHoldGameScene) : void
        {
            this._scene = param1;
            return;
        }// end function

        public function hang() : void
        {
            if (this._isHangUp)
            {
                this.doHang();
            }
            else
            {
                AutoFightManager.getInstance().setMounsterType(new Vector.<int>);
                AutoFightManager.getInstance().taskFight(false);
                TweenLite.killDelayedCallsTo(this.npcClick);
                TweenLite.killDelayedCallsTo(this.autoPick);
            }
            return;
        }// end function

        private function getmyIndexFromTeamList() : int
        {
            var _loc_1:* = TeamModel.getInstance().vecTeamInfo;
            var _loc_2:* = UserObj.getInstance().playerInfo.personId;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                if (_loc_1[_loc_3].memberid.equal(_loc_2))
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return 0;
        }// end function

        private function autoHangUp() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = TeamModel.getInstance().captainId;
            if (_loc_1 && _loc_1.toNumber() > 0)
            {
                _loc_2 = this.getmyIndexFromTeamList();
                this.gotoHangUp(_loc_2);
            }
            else
            {
                this.gotoHangUp(this.POINT_MONST[0]);
            }
            return;
        }// end function

        private function gotoHangUp(param1:int) : void
        {
            var _loc_2:* = this.POINT_MONST[param1];
            this.hangUpPoint = MapUtils.tile2Coo([_loc_2.x, _loc_2.y]);
            Player.state = State.AUTO_ROAD;
            RoleList.getInstance().player.addEvtListener(RoleEvent.ARRIVE, this.runToPoint);
            this.stopConfirmStart();
            RoleList.getInstance().player.pathByCoo(this.hangUpPoint[0], this.hangUpPoint[1]);
            return;
        }// end function

        public function runToPoint(event:RoleEvent) : void
        {
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.runToPoint);
            if (!this.hangUpPoint)
            {
                return;
            }
            AutoFightController.getInstance().openAutoFight();
            return;
        }// end function

        private function getDistance(param1:int, param2:int, param3:Number, param4:Number) : int
        {
            return Math.sqrt(Math.pow(param3 - param1, 2) + Math.pow(param4 - param4, 2));
        }// end function

        private function continueTaskDelayCall(event:RoleEvent) : void
        {
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.removeEvtListener(RoleEvent.ACTION_COMPLETE, this.continueTaskDelayCall);
            FightControl.getInstance().delCurrentSkill();
            UserObj.getInstance().selectRole = null;
            RoleList.getInstance().player.addEvtListener(RoleEvent.ARRIVE, this.__attackDoor);
            RoleList.getInstance().player.pathByCoo(this._saveX, this._saveY, 0, 0, false, false);
            return;
        }// end function

        private function confirmStartHang() : void
        {
            var _loc_1:* = getTimer();
            if (!(MapControl.getInstance().currentGameScene is ScarletHoldGameScene))
            {
                clearInterval(this._confirmStartId);
            }
            if (_loc_1 - this._startConfirmTime > ZoneType.ZONES_SCARLET_START_GAP * 1000)
            {
                this.doHang();
            }
            return;
        }// end function

        private function doHang() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = new Vector.<int>;
            switch(this._model.curPhase)
            {
                case 0:
                {
                    this.hangUpPoint = MapUtils.tile2Coo([this._startPoint.x, this._startPoint.y]);
                    Player.state = State.AUTO_ROAD;
                    clearInterval(this._confirmStartId);
                    this._confirmStartId = setInterval(this.confirmStartHang, 500);
                    this._startConfirmTime = getTimer();
                    RoleList.getInstance().player.pathByCoo(this.hangUpPoint[0], this.hangUpPoint[1]);
                    break;
                }
                case 1:
                {
                    this.autoHangUp();
                    break;
                }
                case 2:
                {
                    AutoFightManager.getInstance().fightLogic.nopatrol = true;
                    TweenLite.delayedCall(1, this.killMonster);
                    break;
                }
                case 3:
                {
                    AutoFightManager.getInstance().fightLogic.nopatrol = true;
                    TweenLite.delayedCall(1, this.killMonster);
                    break;
                }
                case 4:
                {
                    AutoFightManager.getInstance().fightLogic.nopatrol = true;
                    TweenLite.delayedCall(1, this.killMonster);
                    break;
                }
                case 5:
                {
                    AutoFightManager.getInstance().fightLogic.nopatrol = true;
                    TweenLite.delayedCall(1.5, this.autoPick);
                    this.openAutoFight();
                    break;
                }
                case 6:
                {
                    AutoFightManager.getInstance().fightLogic.nopatrol = true;
                    TweenLite.delayedCall(1, this.killMonster);
                    break;
                }
                case 7:
                {
                    AutoFightManager.getInstance().fightLogic.nopatrol = true;
                    _loc_2 = RoleList.getInstance().player as Player;
                    if (_loc_2.cutePet && _loc_2.cutePet.petType == 5)
                    {
                        TweenLite.delayedCall(1, this.npcClick);
                    }
                    else
                    {
                        TweenLite.delayedCall(1.5, this.autoPick);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._model.curPhase >= 2)
            {
                this.stopConfirmStart();
            }
            ZonesControl.getInstance().addScarletListener();
            return;
        }// end function

        private function stopConfirmStart() : void
        {
            clearInterval(this._confirmStartId);
            return;
        }// end function

        private function npcClick() : void
        {
            if (this._scene)
            {
                this._scene.npcClick();
            }
            return;
        }// end function

        private function __attackDoor(event:RoleEvent) : void
        {
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.__attackDoor);
            setTimeout(this.openAutoFight, 200);
            return;
        }// end function

        private function openAutoFight() : void
        {
            if (this._isHangUp)
            {
                AutoFightController.getInstance().openAutoFight();
            }
            return;
        }// end function

        private function killMonster() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(this._model.curPhase)
            {
                case 2:
                {
                    _loc_1 = RoleList.getInstance().getFirstRoleByModelId(this.getBoss(1));
                    Player.state = State.AUTO_ROAD;
                    _loc_2 = MapUtils.tile2Coo([151, 64]);
                    _loc_3 = RoleList.getInstance().player as Player;
                    if (_loc_3 && _loc_3.fatherActType == Params.ACTION_SIMPLE_ATTACK_ID)
                    {
                        this._saveX = _loc_2[0];
                        this._saveY = _loc_2[1];
                        _loc_3.addEvtListener(RoleEvent.ACTION_COMPLETE, this.continueTaskDelayCall);
                        return;
                    }
                    FightControl.getInstance().delCurrentSkill();
                    UserObj.getInstance().selectRole = null;
                    RoleList.getInstance().player.addEvtListener(RoleEvent.ARRIVE, this.__attackDoor);
                    RoleList.getInstance().player.pathByCoo(_loc_2[0], _loc_2[1], 0, 0, false, false);
                    break;
                }
                case 3:
                {
                    AutoFightController.getInstance().openAutoFight();
                    break;
                }
                case 4:
                {
                    AutoFightController.getInstance().openAutoFight();
                    break;
                }
                case 6:
                {
                    AutoFightController.getInstance().openAutoFight();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function autoPick() : void
        {
            if (this._model.curPhase == 7)
            {
                AutoFightManager.getInstance().fightLogic.addEventListener(AutoFightEvent.PICK_COMPLETE_ALL, this.__pickComplete, false, 0, true);
            }
            AutoFightManager.getInstance().fightLogic.pick();
            return;
        }// end function

        private function __pickComplete(event:AutoFightEvent) : void
        {
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.PICK_COMPLETE_ALL, this.__pickComplete);
            this.npcClick();
            return;
        }// end function

        public function getBoss(param1:int) : int
        {
            var _loc_2:* = new Vector.<int>;
            var _loc_3:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesModel.getInstance().zoneid);
            if (_loc_3.boss)
            {
                return _loc_3.boss[(param1 - 1)];
            }
            return 0;
        }// end function

        public function reset() : void
        {
            if (this._model)
            {
                this._model.curPhase = 0;
            }
            this._isHangUp = false;
            AutoFightManager.getInstance().fightLogic.removeEventListener(AutoFightEvent.PICK_COMPLETE_ALL, this.__pickComplete);
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.runToPoint);
            clearInterval(this._confirmStartId);
            return;
        }// end function

        public function start() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < ScarletHoldModel.getInstance().phases.length)
            {
                
                ScarletHoldModel.getInstance().phases[_loc_1].value = 0;
                _loc_1++;
            }
            if (this._model.curPhase == 0)
            {
                this._start = true;
            }
            return;
        }// end function

        public function updateTime(event:TimerManagerEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._timeCount - 1;
            _loc_2._timeCount = _loc_3;
            if (this._scene)
            {
                if (this._timeCount != 0)
                {
                    this._scene.setSystemCue(this._timeCount);
                }
                else
                {
                    this._scene.setSystemCue(0);
                }
            }
            return;
        }// end function

        public function onStartComplete() : void
        {
            this._model.curPhase = 1;
            return;
        }// end function

        public function enterSecondPhase() : void
        {
            this._model.curPhase = 2;
            return;
        }// end function

        public function setPhase(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this._model.zoneid = param2;
            this._model.curPhase = param1;
            if (param1 == -1)
            {
                ZonesControl.getInstance().scarletholdTrace.setComplete();
                return;
            }
            if (this._scene)
            {
                this._scene.updateBlock();
            }
            if (this._isHangUp)
            {
                this.doHang();
            }
            if (this._model.curPhase == 0 && this._start == false)
            {
                this.start();
                ZonesControl.getInstance().scarletholdTrace.setPhase(null);
            }
            if (this._model.curPhase == 2)
            {
                VMCManager.addRes(Params.ROLE_RES_PATH + "ms130/act11/90.png");
            }
            if (this._model.curPhase == 1)
            {
                if (this._clientMonst == null)
                {
                    this._clientMonst = new Role();
                    _loc_4 = MapUtils.tile2Coo([155, 64]);
                    _loc_5 = new RoleInfo();
                    _loc_5.personId = long.fromNumber(MONSTID);
                    _loc_5.cfgId = 11111111;
                    _loc_6 = RoleList.getInstance().player as IRole;
                    var _loc_10:* = _loc_4[0];
                    _loc_5.x = _loc_4[0];
                    this._clientMonst.x = _loc_10;
                    var _loc_10:* = _loc_4[1];
                    _loc_5.y = _loc_4[1];
                    this._clientMonst.y = _loc_10;
                    _loc_5.speed = 0;
                    _loc_5.url = Params.ROLE_RES_PATH + "ms130";
                    this._clientMonst.direct = MapUtils.mapDirect2RoleDir(2);
                    this._clientMonst.info = _loc_5;
                    MapControl.getInstance().addSpeciaRole(this._clientMonst);
                }
            }
            else if (this._model.curPhase > 0)
            {
                if (this._clientMonst != null && this._clientMonst.info)
                {
                    MapControl.getInstance().removeRoleFromMap(this._clientMonst);
                    this._clientMonst = null;
                }
            }
            if (this._model.curPhase == 0)
            {
                ZonesControl.getInstance().scarletholdTrace.clear();
                return;
            }
            if (param3 == 0)
            {
                throw new Error("playcount == 0了，请干翰翰");
            }
            if (this._model.curPhase >= 0)
            {
                _loc_7 = new PhaseVo();
                if (this._model.task[(this._model.curPhase - 1)].describe.indexOf("{1}") != -1)
                {
                    _loc_8 = param3;
                    if (this._model.curPhase == 1)
                    {
                        _loc_9 = 40 + (_loc_8 - 1) * this._model.task[(this._model.curPhase - 1)].target;
                    }
                    else
                    {
                        _loc_9 = _loc_8 * this._model.task[(this._model.curPhase - 1)].target;
                    }
                    _loc_7.describe = (this._model.task[(this._model.curPhase - 1)].describe as String).replace("{1}", _loc_9);
                    _loc_7.target = _loc_9;
                }
                else
                {
                    _loc_7.describe = this._model.task[(this._model.curPhase - 1)].describe;
                    _loc_7.target = this._model.task[(this._model.curPhase - 1)].target;
                }
                _loc_7.completed = 0;
                _loc_7.phase = this._model.curPhase;
                _loc_7.type = this._model.task[(this._model.curPhase - 1)].type;
                ZonesControl.getInstance().scarletholdTrace.setPhase(_loc_7);
            }
            return;
        }// end function

        public function setMonstKill(param1:int) : void
        {
            if (this._model.curPhase == 1 || this._model.curPhase == 3)
            {
                ZonesControl.getInstance().scarletholdTrace.setMonstKill(param1);
            }
            return;
        }// end function

        public function complete(event:TimerManagerEvent) : void
        {
            this._model.curPhase = 1;
            this._start = false;
            this._timeId = null;
            return;
        }// end function

        public function dealNPC(param1:int) : Object
        {
            var _loc_2:* = new Object();
            var _loc_3:* = NpcCfgObj.getInstance().getNpcByID(param1.toString());
            _loc_2.title = _loc_3._npcName;
            _loc_2.talker = _loc_3._npcName;
            if (this._model.curPhase == 7)
            {
                _loc_2.content = LanguageCfgObj.getInstance().getByIndex("11427");
                ZonesControl.getInstance().reqZoneReceiveawards(0, this._model.zoneid);
                AutoFightController.getInstance().closeAutoFight(true);
            }
            else
            {
                _loc_2.content = _loc_3._dialog ? (_loc_3._dialog) : (LanguageCfgObj.getInstance().getByIndex("11428"));
                if (this.isHangUp)
                {
                    TweenLite.delayedCall(3, this.closeNpc);
                }
            }
            var _loc_4:* = [];
            _loc_4.push(LanguageCfgObj.getInstance().getByIndex("11429"));
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_2["label" + (_loc_5 + 1)] = _loc_4[_loc_5];
                _loc_5++;
            }
            return _loc_2;
        }// end function

        private function sendReq() : void
        {
            NpcDialogControl.getInstance().closeNpcDialog();
            ZonesControl.getInstance().reqZoneReceiveawards(0, this._model.zoneid);
            return;
        }// end function

        public function out() : void
        {
            if (this._timeId)
            {
                TimerManager.killTimer(this._timeId);
            }
            return;
        }// end function

        public function cancelPath() : void
        {
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.runToPoint);
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.__attackDoor);
            clearInterval(this._confirmStartId);
            return;
        }// end function

        public function getMonstsByList() : IRole
        {
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesModel.getInstance().zoneid);
            var _loc_3:* = _loc_2.id % 1000;
            _loc_1.push(int("13002" + _loc_3 + "001"));
            _loc_1.push(int("13002" + _loc_3 + "002"));
            _loc_1.push(int("13002" + _loc_3 + "003"));
            _loc_1.push(int("13002" + _loc_3 + "004"));
            return RoleList.getInstance().getNearestMounsterByType(_loc_1);
        }// end function

        public function getMonst() : IRole
        {
            var _loc_1:* = null;
            switch(this._model.curPhase)
            {
                case 1:
                {
                    _loc_1 = this.getMonstsByList();
                    break;
                }
                case 2:
                {
                    _loc_1 = RoleList.getInstance().getFirstRoleByModelId(this.getBoss(1));
                    break;
                }
                case 3:
                {
                    _loc_1 = RoleList.getInstance().getFirstRoleByModelId(this.getBoss(4));
                    RoleList.getInstance().pushNearList();
                    break;
                }
                case 4:
                {
                    _loc_1 = RoleList.getInstance().getFirstRoleByModelId(this.getBoss(2));
                    break;
                }
                case 6:
                {
                    _loc_1 = RoleList.getInstance().getFirstRoleByModelId(this.getBoss(3));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function closeNpc() : void
        {
            NpcDialogControl.getInstance().closeNpcDialog();
            return;
        }// end function

        public function isInblock(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = 0;
            if (this._model.curPhase > 2)
            {
                return true;
            }
            var _loc_4:* = this._model.getBasePoint(this._model.curPhase);
            var _loc_5:* = this._model.getLeftPoint(this._model.curPhase);
            if (param1 < _loc_5.x)
            {
                return true;
            }
            var _loc_6:* = this._model.getSlope(this._model.curPhase);
            _loc_3 = ToolKit.getAngle(_loc_4.x, _loc_4.y, param1, param2);
            return _loc_3 < _loc_6 && _loc_3 > _loc_6 - 180;
        }// end function

        public static function getInstance() : ScarletHoldControl
        {
            var _loc_1:* = new ScarletHoldControl;
            _inst = new ScarletHoldControl;
            return _inst || _loc_1;
        }// end function

    }
}
