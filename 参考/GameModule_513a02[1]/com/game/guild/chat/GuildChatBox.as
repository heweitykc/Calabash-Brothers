package com.game.guild.chat
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.chat.model.*;
    import com.game.chat.view.*;
    import com.game.guild.bean.*;
    import com.game.guild.events.*;
    import com.game.guild.model.*;
    import com.game.operationpanel.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class GuildChatBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var btn_small:BaseButton;
        private var btn_face:BaseButton;
        private var btn_send:BaseButton;
        private var txt_message:TextField;
        private var txt_input:TextField;
        private var txt_bullet:TextField;
        private var txt_member:TextField;
        private var mc_List:MovieClip;
        private var list:List;
        private var _curSelectPerson:MemberInfo;
        private var _inputTxt:ChatInput;
        private var _output:ChatGuildComponent;
        private var _face:FaceSp;
        private var TEMPLATE:String;
        private var _templateTxt:TextField;

        public function GuildChatBox()
        {
            this.TEMPLATE = LanguageCfgObj.getInstance().getByIndex("10738");
            _peaceBox = ["*"];
            loadDisplay("res/guildchat.swf");
            return;
        }// end function

        public function get curSelectPerson() : MemberInfo
        {
            return this._curSelectPerson;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildChat");
            this.initUI();
            this.addEvents();
            this.openFlash();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_face = new BaseButton(getDisplayChildByName("btn_face"));
            this.btn_send = new BaseButton(getDisplayChildByName("btn_send"));
            this.btn_send.setText(LanguageCfgObj.getInstance().getByIndex("10736"));
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn_small = new BaseButton(getDisplayChildByName("btn_small"));
            this.txt_message = getDisplayChildByName("txt_message");
            this.txt_input = getDisplayChildByName("txt_input");
            this.txt_bullet = getDisplayChildByName("txt_bullet");
            this.txt_member = getDisplayChildByName("txt_member");
            this.mc_List = getDisplayChildByName("mc_List");
            this.list = new List(217, 285);
            this.mc_List.addChild(this.list);
            this._output = new ChatGuildComponent(342, 263, 320);
            this._output.move(35, 71);
            addChild(this._output);
            this._inputTxt = new ChatInput();
            this._inputTxt.isMultine = true;
            this._inputTxt.wordWrap = true;
            this._inputTxt.width = 300;
            this._inputTxt.height = 50;
            this._inputTxt.x = 35;
            this._inputTxt.textColor = 16771767;
            this._inputTxt.y = 377;
            addChild(this._inputTxt);
            this._inputTxt.guildChat = this;
            this._face = FaceSp.instance;
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.update();
            return;
        }// end function

        public function addOutTxt(param1:ChatInfo) : void
        {
            this._output.addOutTxt(param1);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            ChatController.getInstance().guild_active_time = 0;
            FrameworkGlobal.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            return;
        }// end function

        private function __keyDownHandler(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case KeyCode.ENTER:
                {
                    if (!UserObj.keyable)
                    {
                        return;
                    }
                    if (stage.focus == this._inputTxt)
                    {
                        this.enter();
                    }
                    else if (!ToolKit.isInputTextField)
                    {
                        if (ChatController.getInstance().isguildActive())
                        {
                            stage.focus = this._inputTxt;
                        }
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

        private function enter() : void
        {
            var _loc_1:* = this._inputTxt.getMsg();
            var _loc_2:* = _loc_1[0];
            var _loc_3:* = _loc_1[1];
            if (_loc_2.length == 0 && _loc_3.length == 0)
            {
                return;
            }
            var _loc_4:* = getTimer();
            var _loc_5:* = ChatModel.getInstance().preTimer[ChatType.CHATTYPE_GROUP];
            if (ChatModel.getInstance().preTimer[ChatType.CHATTYPE_GROUP] == 0 || _loc_4 - _loc_5 > ChatModel.getInteralTime(ChatType.CHATTYPE_GROUP))
            {
                ChatController.getInstance().chatRquest(ChatType.CHATTYPE_GROUP, _loc_2, "", _loc_3);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10737"));
            }
            this._inputTxt.clear();
            this.btn_send.enabled = false;
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_face.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_send.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_small.addEvtListener(MouseEvent.CLICK, this.__click);
            GuildData.getInstance().addEvtListener(GuildEvent.GUILD_INFO_CHANGE, this.updateText);
            GuildData.getInstance().addEvtListener(GuildEvent.MEMBER_INFO_CHANGE, this.update);
            GuildData.getInstance().addEvtListener(GuildEvent.OTHER_MEMBER_INFO_CHANGE, this.updateOtherMemberInfo);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn_face:
                {
                    this._face.x = this.btn_face.x;
                    this._face.y = this.btn_face.y - this.btn_face.height - 2;
                    this._face.position = 2;
                    addChild(this._face);
                    break;
                }
                case this.btn_send:
                {
                    this.enter();
                    break;
                }
                case this.btn_small:
                {
                    this.close();
                    OperationPanelControl.getInstance().showOrHideGuildChatIcon(true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initTemplate() : void
        {
            var _loc_1:* = null;
            if (this._templateTxt == null)
            {
                this._templateTxt = new TextField();
                this._templateTxt.autoSize = "left";
                this._templateTxt.mouseEnabled = false;
                this._templateTxt.x = this._inputTxt.x;
                this._templateTxt.y = this._inputTxt.y - 1;
                _loc_1 = this._templateTxt.defaultTextFormat;
                _loc_1.font = "SimSun";
                this._templateTxt.defaultTextFormat = _loc_1;
            }
            if (this._templateTxt.parent == null)
            {
                addChild(this._templateTxt);
            }
            this._templateTxt.htmlText = this.TEMPLATE;
            this._inputTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            return;
        }// end function

        public function linkToChat(param1:PropInfo) : void
        {
            this._inputTxt.accept(param1);
            return;
        }// end function

        public function decide(param1:int) : void
        {
            this.btn_send.enabled = param1 > 0 ? (true) : (false);
            return;
        }// end function

        public function addFace(param1:String) : void
        {
            this._inputTxt.addFace(param1);
            return;
        }// end function

        private function updateText(event:GuildEvent = null) : void
        {
            if (!stage)
            {
                return;
            }
            var _loc_2:* = GuildData.getInstance().guildInfo;
            if (!_loc_2)
            {
                return;
            }
            this.txt_bullet.text = _loc_2.guildBulletin;
            this.txt_member.text = GuildData.getInstance().getMemberNum() + "/" + _loc_2.memberNum;
            return;
        }// end function

        private function update(event:GuildEvent = null) : void
        {
            var _loc_5:* = null;
            if (event && !stage)
            {
                return;
            }
            var _loc_2:* = GuildData.getInstance().guildInfo;
            if (!_loc_2)
            {
                return;
            }
            this.txt_bullet.text = _loc_2.guildBulletin;
            this.txt_member.text = GuildData.getInstance().getMemberNum() + "/" + _loc_2.memberNum;
            this.list.reset();
            var _loc_3:* = GuildData.getInstance().memberList;
            if (_loc_3)
            {
                _loc_3 = _loc_3.slice();
                _loc_3.sort(this.compare);
            }
            var _loc_4:* = 0;
            while (_loc_3 && _loc_4 < _loc_3.length)
            {
                
                _loc_5 = new GuildChatMemberItem();
                _loc_5.obj = _loc_3[_loc_4];
                _loc_5.addEvtListener(MouseEvent.CLICK, this.__selectItem);
                this.list.add(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

        private function updateOtherMemberInfo(event:GuildEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!stage)
            {
                return;
            }
            var _loc_2:* = 0;
            while (this.list && _loc_2 < this.list.length)
            {
                
                _loc_3 = this.list.getContent(_loc_2) as GuildChatMemberItem;
                _loc_4 = _loc_3.info as MemberInfo;
                if (_loc_4 && _loc_4.userId.equal(event.data.userId))
                {
                    _loc_3.obj = event.data;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function compare(param1:MemberInfo, param2:MemberInfo) : int
        {
            if (param1.lastOnlineTime > 0 && param2.lastOnlineTime > 0)
            {
                if (param1.lastOnlineTime > param2.lastOnlineTime)
                {
                    return -1;
                }
                if (param1.lastOnlineTime < param2.lastOnlineTime)
                {
                    return 1;
                }
                return 0;
            }
            else
            {
                if (param1.lastOnlineTime < param2.lastOnlineTime)
                {
                    return -1;
                }
                if (param1.lastOnlineTime > param2.lastOnlineTime)
                {
                    return 1;
                }
            }
            return 0;
        }// end function

        private function __selectItem(event:MouseEvent) : void
        {
            this._curSelectPerson = (event.currentTarget as GuildChatMemberItem).obj;
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            this.close();
            OperationPanelControl.getInstance().showOrHideGuildChatIcon(false);
            return;
        }// end function

        private function openFlash() : void
        {
            this._inputTxt.clear();
            this.initTemplate();
            this.btn_send.enabled = false;
            this._output.addOutTxts();
            this.assignActiveTime();
            FrameworkGlobal.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            OperationPanelControl.getInstance().filterGuildChatIcon(false);
            OperationPanelControl.getInstance().showOrHideGuildChatIcon(false);
            return;
        }// end function

        private function assignActiveTime() : void
        {
            var _loc_1:* = getTimer();
            ChatController.getInstance().guild_active_time = _loc_1;
            return;
        }// end function

        override public function changeToActive() : void
        {
            this.assignActiveTime();
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            this._inputTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false);
            if (this._templateTxt && this._templateTxt.parent)
            {
                this._templateTxt.parent.removeChild(this._templateTxt);
            }
            this.assignActiveTime();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.openFlash();
                this.update();
            }
            return;
        }// end function

    }
}
