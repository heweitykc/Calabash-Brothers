package com.game.redfortress.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.game.clickstream.*;
    import com.game.redfortress.control.*;
    import com.game.redfortress.model.*;
    import com.game.team.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;

    public class ZonesRedFortressPanel extends BaseBox
    {
        private var _btnEnterRedforetress:BaseButton;
        private var _btnClose:BaseButton;
        private var _awardsHBox:HBox;
        private static var HIT_ENTER_HAS_TEAM:String = LanguageCfgObj.getInstance().getByIndex("11111");

        public function ZonesRedFortressPanel()
        {
            loadDisplay("res/redfortress.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("redfortress");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._btnEnterRedforetress = new BaseButton(getDisplayChildByName("btn_enter_redfortress"));
            this._awardsHBox = new HBox();
            this._awardsHBox.oneRow = 4;
            this._awardsHBox.intervalX = 12;
            this._awardsHBox.intervalY = 7;
            this._awardsHBox.move(71, 397);
            this.addChild(this._awardsHBox);
            this.setAwards();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.freshPanel();
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._btnEnterRedforetress:
                {
                    ClickStream.add(ClickStreamId.CLICK_ChiSeYaoSai_LiJiCanJia);
                    this.clickEnterZones();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickEnterZones() : void
        {
            if (TeamModel.getInstance().hasTeam())
            {
                Global.popManager.cue(HIT_ENTER_HAS_TEAM, LanguageCfgObj.getInstance().getByIndex("11112"), null, this.cueCallYes);
            }
            else
            {
                this.cueCallYes();
            }
            return;
        }// end function

        private function cueCallYes() : void
        {
            ZonesRedFortressControl.getInstance().zonesEnter();
            return;
        }// end function

        private function freshPanel() : void
        {
            return;
        }// end function

        private function setAwards() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesRedfortressModel.ZONES_ID);
            if (_loc_1)
            {
                _loc_2 = _loc_1.reward;
                _loc_3 = _loc_2.split(";");
                _loc_4 = _loc_2.split(";");
                _loc_5 = _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = new IconItem("commonRewardBox2_40");
                    _loc_8 = PropUtil.createItemByCfg(_loc_4[_loc_6]);
                    _loc_7.image.move(4, 3);
                    _loc_7.setWH(46, 46);
                    _loc_7.setInfo(_loc_8);
                    this._awardsHBox.add(_loc_7);
                    _loc_6++;
                }
            }
            return;
        }// end function

    }
}
