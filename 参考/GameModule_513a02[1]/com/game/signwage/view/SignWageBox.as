package com.game.signwage.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.offline.control.*;
    import com.game.signwage.control.*;
    import com.game.worldlevel.control.*;
    import com.view.ui.*;
    import flash.events.*;

    public class SignWageBox extends BaseBox implements IGuide
    {
        private var btnClose:BaseButton;
        private var tabBtn1:BaseButton;
        private var tabBtn2:BaseButton;
        private var tabBtn3:BaseButton;
        private var _tabView1:SignUpView;
        private var _tabView2:ActivityCodeView;
        private var _tabView3:OfflineExpView;
        private var tabContainer:TabContainer;
        private static var swf:String = "res/signup.swf";

        public function SignWageBox(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            loadDisplay(swf);
            return;
        }// end function

        private function get signUpView() : SignUpView
        {
            if (!this._tabView1)
            {
                this._tabView1 = new SignUpView();
                addChild(this._tabView1);
            }
            return this._tabView1;
        }// end function

        private function get offlineExpView() : OfflineExpView
        {
            if (!this._tabView3)
            {
                this._tabView3 = new OfflineExpView();
                addChild(this._tabView3);
            }
            return this._tabView3;
        }// end function

        private function get activityCodeView() : ActivityCodeView
        {
            if (!this._tabView2)
            {
                this._tabView2 = new ActivityCodeView();
                addChild(this._tabView2);
            }
            return this._tabView2;
        }// end function

        public function fillSignSuccessd(param1:int) : void
        {
            this.signUpView.fillSignSuccessed(param1);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("signup");
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.registerGuide();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.tabBtn1 = new BaseButton(getDisplayChildByName("tabBtn1"), true);
            this.tabBtn1.setText(LanguageCfgObj.getInstance().getByIndex("11161"));
            this.tabBtn2 = new BaseButton(getDisplayChildByName("tabBtn2"), true);
            this.tabBtn2.setText(LanguageCfgObj.getInstance().getByIndex("11162"));
            this.tabBtn3 = new BaseButton(getDisplayChildByName("tabBtn3"), true);
            this.tabBtn3.setText(LanguageCfgObj.getInstance().getByIndex("11163"));
            this.tabContainer = new TabContainer();
            this.tabContainer.add(this.tabBtn1, this.signUpView);
            this.tabContainer.add(this.tabBtn2, this.offlineExpView);
            this.tabContainer.add(this.tabBtn3, this.activityCodeView);
            this.tabContainer.selected = SignWageControl.getInstance().selected;
            return;
        }// end function

        private function checkOfflineExpTab() : void
        {
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
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

        private function onAddedToStage(event:Event) : void
        {
            return;
        }// end function

        public function setSignupViewInfo() : void
        {
            if (UILoaded)
            {
                this.signUpView.initSignUpView();
            }
            return;
        }// end function

        public function setSignNum() : void
        {
            if (UILoaded)
            {
                this.signUpView.updateNum();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.guidePause(GuideConfigObj.getInstance().SIGN_WAGE_GUIDE_ID_2);
            this.guidePause(GuideConfigObj.getInstance().SIGN_WAGE_GUIDE_ID_3);
            this._tabView1.close();
            return;
        }// end function

        public function getRewardSuccess(param1:int) : void
        {
            this.signUpView.getRewardSuccess(param1);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this._tabView1.signUpBtn, this, GuideConfigObj.getInstance().SIGN_WAGE_GUIDE_ID_2);
            GuideControl.getInstance().registerGuide(this.btnClose, this, GuideConfigObj.getInstance().SIGN_WAGE_GUIDE_ID_3);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideControl.getInstance().backGuide(param1, 1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded;
        }// end function

        override public function open() : void
        {
            super.open();
            OfflineControl.instance.getRetreatInfo();
            WorldLevelControl.getInstance().reqWorldLevelInfo();
            if (UILoaded)
            {
                this.tabContainer.selected = SignWageControl.getInstance().selected;
            }
            return;
        }// end function

        public function setOffineExp() : void
        {
            return;
        }// end function

    }
}
