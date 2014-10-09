package com.game.xscb.view
{
    import com.*;
    import com.f1.*;
    import com.game.autopk.controller.*;
    import com.game.country.control.*;
    import com.game.fight.control.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.game.role.control.*;
    import com.game.task.*;
    import com.game.utils.*;
    import com.game.xscb.control.*;
    import com.game.xscb.model.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.staticdata.*;
    import flash.events.*;
    import interfaces.role.*;

    public class ScarletHoldGameScene extends GameScene
    {
        private var _control:ScarletHoldControl;
        private var _gap_1:Array;
        private var _gap_2:Array;
        private var _monsts:Array;
        private var _npcer:INpc;
        private var _npc:Array;

        public function ScarletHoldGameScene()
        {
            this._gap_1 = [{tx:81, ty:100}, {tx:82, ty:100}, {tx:82, ty:101}, {tx:83, ty:101}, {tx:83, ty:102}, {tx:84, ty:102}, {tx:84, ty:103}, {tx:85, ty:103}, {tx:85, ty:104}, {tx:86, ty:104}];
            this._gap_2 = [{tx:153, ty:63}, {tx:153, ty:64}, {tx:154, ty:64}, {tx:155, ty:64}, {tx:154, ty:65}, {tx:155, ty:65}, {tx:155, ty:66}, {tx:156, ty:66}, {tx:156, ty:67}, {tx:157, ty:67}];
            this._monsts = [130021008, 130022008, 130023008, 130024008, 130025008, 130026008, 130027008, 130028008];
            this._npc = [401001, 402001, 403001, 404001, 405001, 406001, 407001, 408001];
            this._control = ScarletHoldControl.getInstance();
            this._control.scene = this;
            return;
        }// end function

        override protected function __clickRole(event:MouseEvent) : void
        {
            var _loc_2:* = IRole(event.currentTarget);
            if (!_loc_2)
            {
                return;
            }
            if (ScarletHoldControl.getInstance().isHangUp)
            {
                ScarletHoldControl.getInstance().isHangUp = false;
            }
            ZonesControl.getInstance().updateScarletWaitBtnStatus();
            if (_loc_2.info.cfgId == ScarletHoldControl.getInstance().getBoss(1))
            {
                if (_loc_2.info.personId.equal(long.fromNumber(ScarletHoldControl.MONSTID)))
                {
                    return;
                }
                super.__clickRole(event);
                return;
            }
            super.__clickRole(event);
            return;
        }// end function

        override protected function __clickBg(event:MouseEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (event.target == FrameworkGlobal.stage || event.target == _bgView)
            {
                _loc_2 = event.stageX - _gameLayer.x;
                _loc_3 = event.stageY - _gameLayer.y;
                FightControl.getInstance().delCurrentSkill();
                if (_playerRole && Player.state != State.AUTO_ROAD)
                {
                    TweenLite.killDelayedCallsTo(this.delayStateBack);
                    AutoFightController.getInstance().closeAutoFind();
                    ZonesControl.getInstance().cancelPath();
                    _playerRole.pathByCoo(_loc_2, _loc_3, 0, 0, false, false, false, false);
                    Player.state = State.NONE;
                    GuideControl.getInstance().taskStopPath();
                    TaskGlobal.autoTask = false;
                    NpcControl.getInstance().selectNpc = null;
                    DieLogic.isComingBack = false;
                }
                else
                {
                    Player.state = State.NONE;
                    Global.popManager.txtCue(TaskGlobal.CLICK_SCENE_HINT, 5);
                    TweenLite.delayedCall(5, this.delayStateBack);
                    event.stopImmediatePropagation();
                }
                showStageClickMC(_loc_2, _loc_3);
                CountryControl.getInstance().stopGather();
            }
            return;
        }// end function

        private function delayStateBack() : void
        {
            Player.state = State.AUTO_ROAD;
            return;
        }// end function

        override public function changeMap() : void
        {
            super.changeMap();
            return;
        }// end function

        public function updateBlock() : void
        {
            if (ScarletHoldModel.getInstance().curPhase < 1)
            {
                MapObj.getInstance().generateObstacle(this._gap_2);
                MapObj.getInstance().generateObstacle(this._gap_1);
            }
            else if (ScarletHoldModel.getInstance().curPhase <= 2)
            {
                MapObj.getInstance().generateObstacle(this._gap_2);
                MapObj.getInstance().generateObstacle(this._gap_1, false);
            }
            else
            {
                MapObj.getInstance().generateObstacle(this._gap_2, false);
                MapObj.getInstance().generateObstacle(this._gap_1, false);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            ScarletHoldControl.getInstance().out();
            return;
        }// end function

        override protected function addNPC(param1:INpc) : void
        {
            super.addNPC(param1);
            this._npcer = param1;
            TweenLite.delayedCall(2, this.speak);
            return;
        }// end function

        private function speak() : void
        {
            this._npcer.speak(LanguageCfgObj.getInstance().getByIndex("11439"));
            TweenLite.delayedCall(9, this.stop);
            return;
        }// end function

        private function stop() : void
        {
            this._npcer.stopSpeak();
            return;
        }// end function

        public function npcClick() : void
        {
            if (this._npcer)
            {
                doNpc(this._npcer);
            }
            return;
        }// end function

        public function setSystemCue(param1:int) : void
        {
            MapControl.getInstance().setZoneTime(param1);
            return;
        }// end function

    }
}
