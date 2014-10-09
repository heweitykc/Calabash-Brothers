package com.game.chat.view
{
    import com.cfg.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.chat.consts.*;
    import com.game.chat.control.*;
    import com.game.chat.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.riaidea.text.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    public class LaBaView extends Sprite
    {
        private var _back:Sprite;
        private var _output:RichTextField;
        private var _h:int;
        private var _light:Sprite;
        private var qualityEffect:VMCView;
        private var _horn:ChatButton;
        private var _nameTxt:TextField;
        private var _vipIcon:Sprite;
        private var _vipclass:String;
        private var _gmIcon:Sprite;
        private var _instructorIcon:Sprite;
        private var _iconContainer:Sprite;
        private var _info:ChatInfo;
        private var _disappearTimeId:int;
        private var _chatinfo:ChatInfo;
        private var _delayTime:int;
        private var _counttimes:int;
        private var filter:GlowFilter;
        private var updateTime:int;
        private var note:int = 1;
        private static const LAST_TIME:int = 600000;

        public function LaBaView(param1:int, param2:int)
        {
            this._back = ToolKit.getNew("horn_bg");
            addChild(this._back);
            this._back.width = param1;
            this._back.height = param2;
            this._h = param2;
            this._output = new RichTextField();
            this._output.type = RichTextField.DYNAMIC;
            var _loc_3:* = new TextFormat("SimSun", 12, 16777215, false, false, false);
            _loc_3.leading = 0;
            this._output.defaultTextFormat = _loc_3;
            this._output.textfield.autoSize = TextFieldAutoSize.LEFT;
            this._output.textfield.mouseWheelEnabled = false;
            this._output.textfield.selectable = false;
            this._output.textfield.filters = [FrameworkGlobal.BLACK_FILTER];
            this._output.autoScroll = true;
            this._output.textfield.multiline = false;
            this._output.textfield.wordWrap = false;
            this._output.addEventListener(TextEvent.LINK, this.__link, false, 0, true);
            this._output.setSize(param1 - 5, param2 - 5);
            this._output.mouseEnabled = false;
            this._output.textfield.htmlText = "";
            this._output.textfield.text = "";
            this._output.html = true;
            this._output.placeholderMarginH = 1;
            this._output.lineHeight = 32;
            this._output.y = 5;
            addChild(this._output);
            this.qualityEffect = new VMCView();
            this.qualityEffect.auto = true;
            this.qualityEffect.updatePose("90", true);
            this._iconContainer = new Sprite();
            addChild(this._iconContainer);
            this._horn = new ChatButton(ToolKit.getNew("horn_icon"));
            this._horn.x = 1;
            this._horn.y = 5;
            this._iconContainer.addChild(this._horn);
            this._nameTxt = new TextField();
            this._nameTxt.autoSize = "left";
            _loc_3 = this._nameTxt.defaultTextFormat;
            _loc_3.font = "SimSun";
            this._nameTxt.defaultTextFormat = _loc_3;
            this._nameTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._nameTxt.x = this._horn.x + this._horn.width;
            this._nameTxt.y = 5;
            addChild(this._nameTxt);
            this._light = new Sprite();
            this._light.mouseChildren = false;
            this._light.graphics.beginFill(16711680, 1);
            this._light.graphics.drawRect(0, 0, width - this._horn.width - 5, this._h + 80);
            this._light.graphics.endFill();
            this._light.x = this._horn.x + this._horn.width;
            this._output.x = this._light.x;
            addChild(this._light);
            this._output.mask = this._light;
            this.qualityEffect.move(param1 >> 1, param2 >> 1);
            addChild(this.qualityEffect);
            return;
        }// end function

        public function get info() : ChatInfo
        {
            return this._info;
        }// end function

        public function set info(param1:ChatInfo) : void
        {
            var _loc_4:* = null;
            this._info = param1;
            clearTimeout(this._disappearTimeId);
            this._back.visible = true;
            var _loc_2:* = LanguageCfgObj.getInstance().getByIndex("10474");
            var _loc_3:* = this._horn.x + this._horn.width;
            _loc_2 = _loc_2 + (_loc_3 + "_");
            if (param1.isGM_)
            {
                if (this._gmIcon == null)
                {
                    _loc_4 = getDefinitionByName(ChatCfg.GM_RES_NAME);
                    this._gmIcon = new _loc_4;
                }
                this._gmIcon.x = _loc_3;
                this._gmIcon.y = 10;
                this._iconContainer.addChild(this._gmIcon);
                _loc_3 = _loc_3 + this._gmIcon.width;
                _loc_2 = _loc_2 + ("_gmIcon_" + this._gmIcon.width);
            }
            else if (this._gmIcon)
            {
                if (this._gmIcon.parent)
                {
                    this._iconContainer.removeChild(this._gmIcon);
                }
            }
            if (param1.isInstructor)
            {
                if (this._instructorIcon == null)
                {
                    _loc_4 = getDefinitionByName(ChatCfg.INSTRUCTOR_RES_NAME);
                    this._instructorIcon = new _loc_4;
                }
                this._instructorIcon.x = _loc_3;
                this._instructorIcon.y = 10;
                this._iconContainer.addChild(this._instructorIcon);
                _loc_3 = _loc_3 + this._instructorIcon.width;
                _loc_2 = _loc_2 + ("__instructorIcon_" + this._instructorIcon.width);
            }
            else if (this._instructorIcon)
            {
                if (this._instructorIcon.parent)
                {
                    this._iconContainer.removeChild(this._instructorIcon);
                }
            }
            var _loc_5:* = param1.viptype;
            var _loc_6:* = null;
            if (_loc_5 != VipType.NORMAL && _loc_5 < VipType.TOP_LEVEL)
            {
                _loc_6 = "vip_high_" + param1.vipLevel;
            }
            else if (_loc_5 == VipType.TOP_LEVEL)
            {
                _loc_6 = "vip_top_level_" + param1.vipLevel;
            }
            if (this._vipclass != _loc_6 && _loc_6 != null)
            {
                this._vipclass = _loc_6;
                if (this._vipIcon && this._vipIcon.parent)
                {
                    this._vipIcon.parent.removeChild(this._vipIcon);
                }
                this._vipIcon = ToolKit.getNew(this._vipclass);
                this._vipIcon.x = _loc_3;
                this._vipIcon.y = 10;
                this._iconContainer.addChild(this._vipIcon);
                _loc_3 = _loc_3 + this._vipIcon.width;
                _loc_2 = _loc_2 + ("_vipIcon_" + this._vipIcon.width);
            }
            else
            {
                this._vipclass = _loc_6;
                if (_loc_6 == "" || _loc_6 == null)
                {
                    if (this._vipIcon && this._vipIcon.parent)
                    {
                        this._vipIcon.parent.removeChild(this._vipIcon);
                    }
                    if (this._vipIcon)
                    {
                        this._vipIcon = null;
                    }
                }
                else if (this._vipIcon)
                {
                    this._vipIcon.x = _loc_3;
                    this._vipIcon.y = 10;
                    _loc_3 = _loc_3 + this._vipIcon.width;
                    _loc_2 = _loc_2 + ("_vipIcon_" + this._vipIcon.width);
                    this._iconContainer.addChild(this._vipIcon);
                }
            }
            this._nameTxt.x = _loc_3;
            this._output.clear();
            if (this._info.chatername != UserObj.getInstance().playerInfo.name)
            {
                this._nameTxt.htmlText = "<font color = \'#ffde00\'><u><a href=\'event:user|" + this._info.chatername + "|" + this._info.chater + "\'>" + this._info.chatername + "</a></u>：</font>";
            }
            else
            {
                this._nameTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10475");
            }
            _loc_3 = _loc_3 + this._nameTxt.textWidth;
            _loc_2 = _loc_2 + ("_nameTxt_" + this._nameTxt.textWidth + "_totallength_" + _loc_3);
            var _loc_7:* = ChatUtil.makeSrc(this._info);
            var _loc_10:* = _loc_3;
            this._light.x = _loc_3;
            this._output.x = _loc_10;
            Log.log(_loc_2);
            this._output.append(this._info.txt, _loc_7, true);
            this._output.setSize(this._output.textfield.textWidth + 4, this._output.textfield.textHeight + 10);
            this._nameTxt.y = 16;
            var _loc_8:* = this._output.textfield.textHeight;
            var _loc_9:* = (this._h - _loc_8) * 0.5;
            if (_loc_8 >= 30)
            {
                this._output.y = _loc_9 - 11;
            }
            else if (_loc_8 >= 25)
            {
                this._output.y = _loc_9 - 8;
            }
            else if (_loc_8 <= 20)
            {
                if (_loc_8 < 16)
                {
                    this._output.y = _loc_9 - 3;
                }
                else
                {
                    this._output.y = _loc_9 - 5;
                }
            }
            else
            {
                this._output.y = _loc_9 - 6;
            }
            this.qualityEffect.url = "res/effect/horn.png";
            this.qualityEffect.loadRes(this.qualityEffect.url);
            this.qualityEffect.auto = true;
            this.qualityEffect.repeat = false;
            this.qualityEffect.move((this._back.width >> 1) + 1, this._h >> 1);
            this.qualityEffect.noRepeatCompleteFun = this.endPlayEffect;
            this.qualityEffect.updatePose("90", false);
            addChild(this.qualityEffect);
            this._light.graphics.clear();
            this._light.graphics.beginFill(16711680, 1);
            this._light.graphics.drawRect(0, 0, ChatConst.CHAT_WIDTH - _loc_3 - 3, this._h + 60);
            this._light.graphics.endFill();
            removeEventListener(Event.ENTER_FRAME, this.__move);
            this._nameTxt.addEventListener(TextEvent.LINK, this.__link);
            clearTimeout(this._delayTime);
            this.startMove();
            this._disappearTimeId = setTimeout(this.clear, LAST_TIME);
            return;
        }// end function

        private function clear() : void
        {
            ToolKit.disappear(this._gmIcon);
            ToolKit.disappear(this._instructorIcon);
            ToolKit.disappear(this._vipIcon);
            this._output.clear();
            this._nameTxt.text = "";
            this._back.visible = false;
            ChatController.getInstance().clearLabaInfo();
            return;
        }// end function

        protected function endPlayEffect() : void
        {
            if (this.qualityEffect && this.qualityEffect.parent)
            {
                this.qualityEffect.parent.removeChild(this.qualityEffect);
            }
            this.qualityEffect.finalize();
            return;
        }// end function

        private function __move(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._counttimes + 1;
            _loc_2._counttimes = _loc_3;
            if (this._counttimes == 3)
            {
                this._counttimes = 0;
            }
            if (this._counttimes % 2 == 0)
            {
                var _loc_2:* = this._output;
                var _loc_3:* = _loc_2.x - 1;
                _loc_2.x = _loc_3;
            }
            if (_loc_2.x == this._light.x - _loc_2.width - 4)
            {
                removeEventListener(Event.ENTER_FRAME, this.__move);
                this._delayTime = setTimeout(this.startMove, 500);
            }
            return;
        }// end function

        private function startMove() : void
        {
            clearTimeout(this._delayTime);
            if (this._output.textfield.textWidth + 4 + this._nameTxt.width > ChatConst.CHAT_WIDTH - this._iconContainer.width)
            {
                this._output.x = this._light.x + this._light.width;
                addEventListener(Event.ENTER_FRAME, this.__move, false, 0, true);
            }
            else
            {
                this._output.x = this._light.x;
            }
            return;
        }// end function

        public function getHeight() : int
        {
            return this._h;
        }// end function

        private function __link(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            return;
        }// end function

        public function setSize(param1:int) : void
        {
            this._back.width = param1;
            this._output.setSize(param1 - 40, this._output.height);
            return;
        }// end function

        public function shrink() : void
        {
            this._back.visible = false;
            return;
        }// end function

        public function reshow(param1:ChatInfo, param2:int) : int
        {
            var _loc_3:* = getTimer();
            if (param1 == null || _loc_3 - param2 > LAST_TIME)
            {
                this.clear();
                return 0;
            }
            this.info = param1;
            return 1;
        }// end function

        public function startLight() : void
        {
            if (this._light)
            {
                this._light.graphics.clear();
                this._light.graphics.lineStyle(2, 16766976);
                this._light.graphics.moveTo(2, 2);
                this._light.graphics.lineTo(width - 2, 2);
                this._light.graphics.lineTo(width - 2, this.getHeight() - 2);
                this._light.graphics.lineTo(2, this.getHeight() - 2);
                this._light.graphics.lineTo(2, 2);
                if (FrameworkGlobal.stage)
                {
                    FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
                }
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_3:* = this;
            var _loc_4:* = this.updateTime + 1;
            _loc_3.updateTime = _loc_4;
            if (this.updateTime == 3)
            {
                this.updateTime = 0;
                if (this.filter.strength >= 1.5)
                {
                    this.note = -1;
                    var _loc_3:* = 15;
                    this.filter.blurY = 15;
                    this.filter.blurX = _loc_3;
                    this.filter.strength = 1.5;
                }
                else if (this.filter.strength <= 0)
                {
                    this.note = 1;
                    var _loc_3:* = 0;
                    this.filter.blurY = 0;
                    this.filter.blurX = _loc_3;
                    this.filter.strength = 0;
                }
                this.filter.blurX = this.filter.blurX + 1.5 * this.note * 1.2;
                this.filter.blurY = this.filter.blurY + 1.5 * this.note * 1.2;
                this.filter.strength = this.filter.strength + 0.15 * this.note * 1.2;
            }
            var _loc_2:* = 0;
            this._light.filters = [this.filter];
            return;
        }// end function

    }
}
