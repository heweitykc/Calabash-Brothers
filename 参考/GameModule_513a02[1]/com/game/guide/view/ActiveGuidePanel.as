package com.game.guide.view
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.equipstreng.control.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.sound.control.*;
    import com.game.task.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ActiveGuidePanel extends BaseBox
    {
        private var _info:Object;
        private var _curNum:int;
        private var delayInfo:Array;
        private var _okBtn:BaseButton;
        private var bitmap:Bitmap;
        private var _nameTxt:TextField;

        public function ActiveGuidePanel()
        {
            setWH(386, 203);
            _peaceBox = ["*"];
            loadDisplay("res/activeguide.swf");
            this.delayInfo = [];
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.updateView();
            SoundControl.getInstance().playSound(SoundFlag.OPEN_FUNCTION);
            return;
        }// end function

        override public function close() : void
        {
            this.showActive();
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._okBtn);
            super.close();
            Global.mainUIManager.removeUI(this);
            this._info = null;
            return;
        }// end function

        private function showActive() : void
        {
            var tempInfo:Object;
            if (this.info)
            {
                ClickStream.openFunction(this.info.q_guide_team_id);
                tempInfo = this.info;
                if (int(tempInfo.q_guid_delayshow) == 0)
                {
                    GuideControl.getInstance().beginGuide(int(tempInfo.q_guide_team_id));
                    GuideMultiControl.getInstance().beginGuide(int(tempInfo.q_guide_team_id));
                }
                else
                {
                    TweenLite.delayedCall(3, function () : void
            {
                GuideControl.getInstance().beginGuide(int(tempInfo.q_guide_team_id));
                GuideMultiControl.getInstance().beginGuide(int(tempInfo.q_guide_team_id));
                return;
            }// end function
            );
                    FrameworkGlobal.addMsgListen(GameEvent.TOP_ACTIVATE_BTN_MOVE_EFFECT_COMPLETE, this.moveEffectComplete);
                    this.delayInfo.push(tempInfo);
                }
                GuideConfigObj.getInstance().dispatchEvt(new GuideEvent(GuideEvent.GUIDE_ACTIVE, this.info.q_guide_team_id));
            }
            return;
        }// end function

        private function moveEffectComplete(event:GameEvent) : void
        {
            var _loc_2:* = null;
            if (this.delayInfo.length)
            {
                _loc_2 = this.delayInfo.shift();
                GuideControl.getInstance().beginGuide(int(_loc_2.q_guide_team_id));
                GuideMultiControl.getInstance().beginGuide(int(_loc_2.q_guide_team_id));
                if (this.delayInfo.length == 0)
                {
                    FrameworkGlobal.removeMsgListen(GameEvent.TOP_ACTIVATE_BTN_MOVE_EFFECT_COMPLETE, this.moveEffectComplete);
                }
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("active_mc");
            this.initUI();
            this.updateView();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._okBtn = new BaseButton(getDisplayChildByName("ok_btn"));
            this._nameTxt = getDisplayChildByName("txt");
            this._nameTxt.mouseEnabled = false;
            this._okBtn.addEventListener(MouseEvent.CLICK, this.clickHandler);
            this.bitmap = new Bitmap();
            addChild(this.bitmap);
            this.bitmap.x = 161;
            this.bitmap.y = 9;
            return;
        }// end function

        private function updateView() : void
        {
            if (UILoaded)
            {
                this._nameTxt.text = this.info.q_btn_des;
                this.bitmap.bitmapData = ToolKit.getNew("active_" + this.info.q_guide_team_id) as BitmapData;
                ButtonFlickerControl.getInstance().addButtonFlicker(this._okBtn);
                if (TaskGlobal.TEST_MODEL)
                {
                    TweenLite.delayedCall(TaskGlobal.AUTO_GUIDE_CLICK, function () : void
            {
                _okBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        public function get info() : Object
        {
            return this._info;
        }// end function

        public function set info(param1:Object) : void
        {
            if (this._info && this._info != param1)
            {
                this.showActive();
            }
            if (this._info && this._info.q_guide_team_id == GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)
            {
                GuideConfigObj.getInstance().isRolePointActiveing = false;
            }
            this._info = param1;
            return;
        }// end function

        private function clickHandler(event:MouseEvent) : void
        {
            switch(event.currentTarget)
            {
                case this._okBtn:
                {
                    if (this._info.q_guide_team_id == GuideConfigObj.getInstance().SUIT_OPT_TEAM)
                    {
                        EquipForgeControl.getInstance().openEquipForgeBox(4);
                    }
                    else if (this._info.q_guide_team_id == GuideConfigObj.getInstance().SUIT_OPT_TEAM)
                    {
                        EquipForgeControl.getInstance().openEquipForgeBox(5);
                    }
                    else if (this._info.q_guide_team_id == GuideConfigObj.getInstance().BOSS_HOME)
                    {
                        ZonesControl.getInstance().openBossHome();
                    }
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
