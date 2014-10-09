package com.test
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.scroller.*;
    import com.game.historymsg.bean.*;
    import com.game.historymsg.model.*;
    import com.game.hotkeyguide.control.*;
    import com.game.newactivity.handler.*;
    import com.game.newactivity.message.*;
    import com.game.supervip.control.*;
    import com.game.supervip.message.*;
    import com.game.worldlevel.control.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;

    public class TestJinhui extends BaseSprite
    {
        private var font:String = "宋体";
        private var fontSize:uint = 12;
        private var menus:Array;
        private var menuY:int = 0;
        private var scrollViewContent:Sprite;

        public function TestJinhui()
        {
            var bg:Bitmap;
            var scrollView:ScrollPanel;
            this.menus = new Array();
            this.scrollViewContent = new Sprite();
            this.addMenus();
            bg = new Bitmap(new BitmapData(this.scrollViewContent.width, Math.min(this.scrollViewContent.height, 600), true, 2130706432));
            scrollView = new ScrollPanel(bg.width, bg.height);
            scrollView.content = this.scrollViewContent;
            var btnSwitchVisible:* = new TextField();
            btnSwitchVisible.defaultTextFormat = new TextFormat(this.font, this.fontSize, 16777215);
            btnSwitchVisible.autoSize = TextFieldAutoSize.LEFT;
            btnSwitchVisible.text = "▼";
            var _loc_2:* = btnSwitchVisible.width;
            scrollView.x = btnSwitchVisible.width;
            bg.x = _loc_2;
            addChild(bg);
            addChild(btnSwitchVisible);
            addChild(scrollView);
            var _loc_2:* = false;
            scrollView.visible = false;
            bg.visible = _loc_2;
            btnSwitchVisible.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
            {
                var _loc_2:* = !scrollView.visible;
                scrollView.visible = !scrollView.visible;
                bg.visible = _loc_2;
                return;
            }// end function
            );
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                startDrag();
                return;
            }// end function
            );
            addEventListener(MouseEvent.MOUSE_UP, function (event:MouseEvent) : void
            {
                stopDrag();
                return;
            }// end function
            );
            x = 350;
            y = 0;
            var layerContainer:* = Global.popManager.cueMaskLayer.parent;
            layerContainer.addChildAt(this, (layerContainer.numChildren - 1));
            return;
        }// end function

        private function addMenus() : void
        {
            this.addMenu(LanguageCfgObj.getInstance().getByIndex("11541"), WorldLevelControl.getInstance().openWorldLevelPanel);
            this.addMenu(LanguageCfgObj.getInstance().getByIndex("11542"), function (param1:String) : void
            {
                var _loc_2:* = param1.split("|");
                var _loc_3:* = new HistorymsgMsg();
                _loc_3.title = _loc_2[0];
                _loc_3.content = _loc_2[1];
                HistorymsgData.getInstance().addMsg(_loc_3);
                return;
            }// end function
            , true);
            this.addMenu(LanguageCfgObj.getInstance().getByIndex("11543"), function (param1:String) : void
            {
                if (param1 == " ")
                {
                    param1 = "space";
                }
                if (["~", "space", "a", "j"].indexOf(param1) < 0)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11544"));
                    return;
                }
                HotkeyGuideControl.getInstance().showHotkeyGuide(param1);
                return;
            }// end function
            , true);
            this.addMenu(LanguageCfgObj.getInstance().getByIndex("11545"), function () : void
            {
                var _loc_1:* = new ResGetSuperVipInfoMessage();
                _loc_1.name = LanguageCfgObj.getInstance().getByIndex("11634");
                _loc_1.qq = "123456789";
                _loc_1.limit = 3000;
                _loc_1.recharge = 1000;
                _loc_1.pic = "res/image/supervip/gm.png";
                SupervipControl.getInstance().resGetSuperVipInfo(_loc_1);
                return;
            }// end function
            );
            this.addMenu("特权礼包报错", function (param1:String) : void
            {
                var _loc_2:* = null;
                if (ResGetPlatformGiftErrorHandler.handler != null)
                {
                    _loc_2 = new ResGetPlatformGiftError();
                    _loc_2.errorId = int(param1);
                    ResGetPlatformGiftErrorHandler.handler(_loc_2);
                }
                return;
            }// end function
            , true);
            return;
        }// end function

        private function addMenu(param1:String, param2:Function, param3:Boolean = false) : void
        {
            var argEdit:TextField;
            var name:* = param1;
            var callback:* = param2;
            var callbackHasArg:* = param3;
            var label:* = new TextField();
            label.defaultTextFormat = new TextFormat(this.font, this.fontSize, 16777215);
            label.selectable = false;
            label.background = true;
            label.backgroundColor = 0;
            label.width = 100;
            label.height = 20;
            label.text = name;
            label.y = this.menuY;
            this.scrollViewContent.addChild(label);
            argEdit;
            if (callbackHasArg)
            {
                argEdit = new TextField();
                argEdit.type = TextFieldType.INPUT;
                argEdit.defaultTextFormat = new TextFormat(this.font, this.fontSize, 16777215);
                argEdit.width = 100;
                argEdit.height = 20;
                argEdit.background = true;
                argEdit.backgroundColor = 0;
                argEdit.x = label.width + 1;
                argEdit.y = this.menuY;
                this.scrollViewContent.addChild(argEdit);
            }
            this.menuY = this.menuY + (label.height + 1);
            var handler:* = function (event:Event = null) : void
            {
                if (callbackHasArg)
                {
                    callback(argEdit.text);
                }
                else
                {
                    callback();
                }
                return;
            }// end function
            ;
            label.addEventListener(MouseEvent.CLICK, handler);
            if (callbackHasArg)
            {
                argEdit.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                if (event.charCode == Keyboard.ENTER)
                {
                    handler();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

    }
}
