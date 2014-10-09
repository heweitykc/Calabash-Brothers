package com.game.chat.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.chat.consts.*;
    import com.game.chat.model.*;
    import com.game.chat.protocol.*;
    import com.game.chat.view.*;
    import com.game.guild.control.*;
    import com.game.operationpanel.control.*;
    import com.game.utils.*;
    import com.game.vip.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class ChatController extends Object
    {
        private var _hornInput:HornPanel;
        private var _chatProtocol:ChatProtocol;
        private var _chat:ChatComponent;
        private var _face:FaceSp;
        private var _chatList:ChatSearchList;
        public var chat_active_time:int;
        public var horn_active_time:int;
        public var guild_active_time:int;
        private var _labaBuff:FunctionBuffer;
        private var _labaArr:Array;
        private var _preQueryTime:int;
        private static var _instance:ChatController;

        public function ChatController()
        {
            this._chatProtocol = new ChatProtocol();
            this._labaBuff = new FunctionBuffer(5);
            this._labaArr = new Array();
            if (FrameworkGlobal.language == "ft")
            {
                ChatConst.WORLD_SPEAK_LEVEL = 20;
            }
            return;
        }// end function

        public function get hornInput() : HornPanel
        {
            return this._hornInput;
        }// end function

        public function set hornInput(param1:HornPanel) : void
        {
            this._hornInput = param1;
            return;
        }// end function

        public function get chatList() : ChatSearchList
        {
            return this._chatList;
        }// end function

        public function set chatList(param1:ChatSearchList) : void
        {
            this._chatList = param1;
            return;
        }// end function

        public function get chat() : ChatComponent
        {
            return this._chat;
        }// end function

        public function set chat(param1:ChatComponent) : void
        {
            this._chat = param1;
            return;
        }// end function

        public function chatRquest(param1:int, param2:String, param3:String = "", param4:Vector.<ChatGoodInfo> = null, param5:long = null) : void
        {
            if (param1 != ChatType.CHATTYPE_HORN && param1 != ChatType.CHATTYPE_GROUP)
            {
                if (param1 == ChatType.CHATTYPE_WORLD && UserObj.getInstance().playerInfo.level < ChatConst.WORLD_SPEAK_LEVEL)
                {
                    Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12355"), [ChatConst.WORLD_SPEAK_LEVEL]));
                    return;
                }
                if (param1 != ChatType.CHATTYPE_WORLD && UserObj.getInstance().playerInfo.level < ChatConst.SPEAK_LEVEL)
                {
                    Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12355"), [ChatConst.SPEAK_LEVEL]));
                    return;
                }
            }
            if (!UserObj.getInstance().playerInfo.isBlack() || param1 == 5)
            {
                this._chatProtocol.charRequest(param1, param2, param3, param4);
            }
            else
            {
                this.selfRequest(param1, param2, param3, param4);
            }
            ChatModel.getInstance().preTimer[param1] = getTimer();
            return;
        }// end function

        public function selfRequest(param1:int, param2:String, param3:String = "", param4:Vector.<ChatGoodInfo> = null) : void
        {
            var _loc_5:* = new ChatInfo();
            _loc_5.chater = UserObj.getInstance().playerInfo.personId;
            _loc_5.chaterlevel = UserObj.getInstance().playerInfo.level;
            _loc_5.chatername = UserObj.getInstance().playerInfo.name;
            _loc_5.chattype = param1;
            _loc_5.condition = param2;
            _loc_5.other = param4;
            _loc_5.receivername = param3;
            _loc_5.receiver = null;
            _loc_5.viptype = VipModel.getInstance().info.stageLevel;
            _loc_5.vipLevel = VipModel.getInstance().info.level;
            _loc_5.parse();
            ChatController.getInstance().accept(_loc_5);
            var _loc_6:* = _loc_5.clone();
            _loc_6.parse(false);
            SpeakControl.getInstance().speakByChatInfo(_loc_6);
            return;
        }// end function

        public function accept(param1:ChatInfo) : void
        {
            var _loc_2:* = null;
            if (param1.chattype != ChatType.CHATTYPE_HORN)
            {
                ChatModel.getInstance().accept(param1);
                if (this._chat && this._chat.inited)
                {
                    this._chat.accept(param1);
                }
                if (param1.chattype == ChatType.CHATTYPE_GROUP)
                {
                    _loc_2 = param1.clone();
                    GuildControl.getInstance().acceptChat(_loc_2);
                    if (!GuildControl.getInstance().isGuildChatBoxOpen())
                    {
                        OperationPanelControl.getInstance().showOrHideGuildChatIcon(true);
                        OperationPanelControl.getInstance().filterGuildChatIcon(true);
                    }
                }
            }
            else if (this._chat && this._chat.inited)
            {
                this._chat.paintLaBa(param1);
            }
            return;
        }// end function

        public function clearLabaInfo() : void
        {
            if (this._chat)
            {
                this._chat.clearLabaInfo();
            }
            return;
        }// end function

        private function drawHorn() : void
        {
            var _loc_1:* = null;
            if (this._chat)
            {
                _loc_1 = this._labaArr.shift();
                this._chat.paintLaBa(_loc_1);
            }
            return;
        }// end function

        public function openHorn() : void
        {
            if (this._hornInput == null)
            {
                this._hornInput = new HornPanel();
                Global.popManager.addPop(this._hornInput);
            }
            this._hornInput.open();
            return;
        }// end function

        public function addFace(param1:String, param2:int = 0) : void
        {
            if (param2 == ChatConst.HORN_FACE)
            {
                this._hornInput.addToFace(param1);
            }
            else if (param2 == ChatConst.GROUP_FACE)
            {
                GuildControl.getInstance().addToFace(param1);
            }
            else
            {
                this._chat.addToFace(param1);
            }
            return;
        }// end function

        public function addOutListener() : void
        {
            if (this._chat)
            {
                this._chat.addOutListener(true);
            }
            return;
        }// end function

        public function openFace() : void
        {
            if (this._face == null)
            {
                this._face = FaceSp.instance;
            }
            if (!this._face.parent)
            {
                this._chat.addOutListener(false);
                this._chat.addFace(this._face);
            }
            else
            {
                this._face.parent.removeChild(this._face);
                this._chat.addOutListener(false);
            }
            return;
        }// end function

        public function ishornActive() : Boolean
        {
            return Math.max(this.chat_active_time, this.horn_active_time, this.guild_active_time) == this.horn_active_time;
        }// end function

        public function isguildActive() : Boolean
        {
            return Math.max(this.chat_active_time, this.horn_active_time, this.guild_active_time) == this.guild_active_time;
        }// end function

        public function ischatActive() : Boolean
        {
            return Math.max(this.chat_active_time, this.horn_active_time, this.guild_active_time) == this.chat_active_time;
        }// end function

        public function linkToChat(param1:PropInfo) : void
        {
            if (this._hornInput && this._hornInput.isOpen && Math.max(this.chat_active_time, this.horn_active_time, this.guild_active_time) == this.horn_active_time)
            {
                this._hornInput.linkToChat(param1);
            }
            else if (GuildControl.getInstance().isGuildChatBoxOpen() && Math.max(this.chat_active_time, this.horn_active_time, this.guild_active_time) == this.guild_active_time)
            {
                GuildControl.getInstance().linkToChat(param1);
            }
            else
            {
                this._chat.linkToChat(param1);
            }
            return;
        }// end function

        public function openLookList(param1:int = 1) : void
        {
            if (this._chatList == null)
            {
                this._chatList = new ChatSearchList("chatLookList");
                Global.popManager.addPop(this._chatList, true, false, true, true, false, true);
            }
            this._chatList.type = param1;
            this._chatList.openOrClose();
            return;
        }// end function

        public function query(param1:int = 1) : Boolean
        {
            var _loc_2:* = getTimer();
            if (this._preQueryTime == 0 || _loc_2 - this._preQueryTime > 10000)
            {
                this._preQueryTime = _loc_2;
                this._chatProtocol.query(param1);
                return true;
            }
            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10440"));
            return false;
        }// end function

        public function queryName(param1:String) : void
        {
            var _loc_2:* = getTimer();
            if (this._preQueryTime == 0 || _loc_2 - this._preQueryTime > 10000)
            {
                this._preQueryTime = _loc_2;
                this._chatProtocol.queryName(param1);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10440"));
            }
            return;
        }// end function

        public function toGm(param1:String) : void
        {
            this._chatProtocol.toGM(param1);
            return;
        }// end function

        public function toRole(param1:String) : void
        {
            this._chat.changeToRole(param1);
            return;
        }// end function

        public function acceptRole(param1:Array) : void
        {
            this._chatList.list = param1;
            return;
        }// end function

        public function systemCue(param1:String) : void
        {
            var _loc_2:* = new ChatInfo();
            _loc_2.chattype = ChatType.CHATTYPE_SYSTEM;
            _loc_2.condition = param1;
            _loc_2.parse();
            this.accept(_loc_2);
            return;
        }// end function

        public function addtoCue(param1:String, param2:Array = null) : void
        {
            var _loc_4:* = null;
            if (param2 == null)
            {
                if (this._chat)
                {
                    param2 = [ChatType.CHATTYPE_SYSTEM];
                }
                else
                {
                    param2 = [ChatType.CHATTYPE_SYSTEM];
                }
            }
            var _loc_3:* = 0;
            while (_loc_3 < param2.length)
            {
                
                _loc_4 = new ChatInfo();
                _loc_4.chattype = param2[_loc_3];
                _loc_4.condition = param1;
                _loc_4.parse();
                ChatModel.getInstance().addToCue(_loc_4);
                if (this._chat && this._chat.inited)
                {
                    this._chat.addCue(_loc_4);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function addSystemAndCue(param1:String, param2:int) : void
        {
            var _loc_3:* = new ChatInfo();
            _loc_3.chattype = param2;
            _loc_3.condition = param1;
            _loc_3.parse();
            this.accept(_loc_3);
            return;
        }// end function

        public static function getInstance() : ChatController
        {
            var _loc_1:* = new ChatController;
            _instance = new ChatController;
            return _instance || _loc_1;
        }// end function

    }
}
