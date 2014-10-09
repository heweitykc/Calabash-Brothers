package com.game.newactivity.moonFestival.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.newactivity.moonFestival.view.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MoonBossView extends Component implements IMoonFestivalView
    {
        private const BOSS_TIME:Array;
        private var _txtDownTime:TextField;
        private var _downTime:DownTimer;
        private var _vmcBossPhoto:VMCView;
        private var _btnBossHelp:BaseButton;
        private var _mcBossTips:MovieClip;

        public function MoonBossView(param1 = null, param2:String = null)
        {
            this.BOSS_TIME = ["10:30", "14:30", "18:30", "22:30"];
            initComponentUI(param1);
            this.displayReady();
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._txtDownTime = TextField(getDisplayChildByName("txt_down_time"));
            this._btnBossHelp = new BaseButton(getDisplayChildByName("btn_boss_help"));
            this._mcBossTips = MovieClip(getDisplayChildByName("mc_boss_tips"));
            this._mcBossTips.visible = false;
            this._downTime = new DownTimer();
            this._downTime.callBack = this.callDownBack;
            return;
        }// end function

        private function callDownBack() : void
        {
            if (this._txtDownTime)
            {
                this._txtDownTime.text = this._downTime.second2TimeStr("小时分钟秒");
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this._btnBossHelp.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this._btnBossHelp.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onRemoveToStage);
            return;
        }// end function

        protected function onMouseOut(event:MouseEvent) : void
        {
            this._mcBossTips.visible = false;
            return;
        }// end function

        protected function onMouseOver(event:MouseEvent) : void
        {
            this._mcBossTips.visible = true;
            this.addChild(this._mcBossTips);
            this.setChildIndex(this._mcBossTips, (this.numChildren - 1));
            return;
        }// end function

        protected function onRemoveToStage(event:Event) : void
        {
            this.removeBoss();
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.update();
            this.showBoss();
            return;
        }// end function

        private function showBoss() : void
        {
            if (!this._vmcBossPhoto)
            {
                this._vmcBossPhoto = new VMCView();
                this._vmcBossPhoto.auto = true;
                this._vmcBossPhoto.move(253, 286);
            }
            var _loc_1:* = MonsterCfgObj.getInstance().getMonsterCfg(399990001);
            if (_loc_1)
            {
                this.addChild(this._vmcBossPhoto);
                this._vmcBossPhoto.loadRes(Params.ROLE_RES_PATH + _loc_1.q_sculpt_resid + "/act01/180.png", null, true);
                this._vmcBossPhoto.updatePose("180", true);
            }
            return;
        }// end function

        private function removeBoss() : void
        {
            return;
        }// end function

        public function updateByActInfo(param1:NewActivityInfo) : void
        {
            this.update();
            return;
        }// end function

        private function update() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_1:* = ToolKit.getServerDate();
            var _loc_2:* = this.BOSS_TIME.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_4 = String(this.BOSS_TIME[_loc_5]).split(":");
                _loc_3 = int(_loc_4[0]) * 3600 + int(_loc_4[1]) * 60 - (_loc_1.hours * 3600 + _loc_1.minutes * 60 + _loc_1.seconds);
                if (_loc_3 > 0)
                {
                    break;
                }
                _loc_5++;
            }
            if (_loc_3 < 0)
            {
                _loc_4 = String(this.BOSS_TIME[0]).split(":");
                _loc_3 = int(_loc_4[0]) * 3600 + int(_loc_4[1]) * 60 + 24 * 3600 - (_loc_1.hours * 3600 + _loc_1.minutes * 60 + _loc_1.seconds);
            }
            this._downTime.count = Math.abs(_loc_3 * 1000);
            return;
        }// end function

    }
}
