package com.game.settings
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import flash.events.*;

    public class SettingsBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var checkBtn1:BaseButton;
        private var checkBtn2:BaseButton;
        private static var _instance:SettingsBox;

        public function SettingsBox()
        {
            loadDisplay("res/settings.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("settingBox");
            this.initUI();
            mute = true;
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.checkBtn1 = new BaseButton(getDisplayChildByName("check_btn1"), true);
            this.checkBtn1.setText(LanguageCfgObj.getInstance().getByIndex("11129"));
            if (FrameworkGlobal.showHighLevelShadow)
            {
                this.checkBtn1.selected = true;
            }
            else
            {
                this.checkBtn1.selected = false;
            }
            this.checkBtn1.addEventListener(MouseEvent.CLICK, this.__check, false, 0, true);
            this.checkBtn2 = new BaseButton("sel_box_btn", true);
            this.checkBtn2.move(52, 130);
            this.checkBtn2.setText(LanguageCfgObj.getInstance().getByIndex("11130"));
            this.checkBtn2.selected = true;
            this.checkBtn2.addEventListener(MouseEvent.CLICK, this.__check, false, 0, true);
            addChild(this.checkBtn2);
            FrameworkGlobal.addMsgListen("showShadow", this.setModel);
            FrameworkGlobal.addMsgListen("hideShadow", this.setModel);
            FrameworkGlobal.addMsgListen("showBgEffect", this.__setGgEffect);
            FrameworkGlobal.addMsgListen("hideBgEffect", this.__setGgEffect);
            return;
        }// end function

        private function __check(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.checkBtn1:
                {
                    if (this.checkBtn1.selected)
                    {
                        FrameworkGlobal.sendMsg(new Event("showShadow"));
                        FrameworkGlobal.showHighLevelShadow = true;
                    }
                    else
                    {
                        FrameworkGlobal.sendMsg(new Event("hideShadow"));
                        FrameworkGlobal.showHighLevelShadow = false;
                    }
                    break;
                }
                case this.checkBtn2:
                {
                    if (this.checkBtn2.selected)
                    {
                        FrameworkGlobal.isShowGameEffect = true;
                        FrameworkGlobal.sendMsg(new Event("showBgEffect"));
                    }
                    else
                    {
                        FrameworkGlobal.isShowGameEffect = false;
                        FrameworkGlobal.sendMsg(new Event("hideBgEffect"));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setModel(event:Event) : void
        {
            switch(event.type)
            {
                case "showShadow":
                {
                    this.checkBtn1.selected = true;
                    break;
                }
                case "hideShadow":
                {
                    this.checkBtn1.selected = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __setGgEffect(event:Event) : void
        {
            switch(event.type)
            {
                case "showBgEffect":
                {
                    this.checkBtn2.selected = true;
                    break;
                }
                case "hideBgEffect":
                {
                    this.checkBtn2.selected = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            close();
            return;
        }// end function

        override public function keyUpHandler(event:KeyboardEvent, param2:Boolean = false) : void
        {
            if (param2)
            {
                event.stopImmediatePropagation();
            }
            if (event.keyCode == KeyCode.ESCAPE)
            {
                close();
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        public static function getInstance() : SettingsBox
        {
            if (_instance == null)
            {
                _instance = new SettingsBox;
                Global.popManager.addPop(_instance);
            }
            return _instance;
        }// end function

    }
}
