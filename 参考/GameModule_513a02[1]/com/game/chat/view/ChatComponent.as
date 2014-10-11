package com.game.chat.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.chat.consts.*;
    import com.game.chat.control.*;
    import com.game.chat.events.*;
    import com.game.chat.model.*;
    import com.game.confirm.*;
    import com.game.guide.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class ChatComponent extends Component
    {
        private var _buttons:Buttons;
        private var _input:ChatInput;
        private var _chatPan:List;
        private var _upBtn:BaseButton;
        private var _downBtn:BaseButton;
        private var _totalTab:BaseButton;
        private var _worldTab:BaseButton;
        private var _roleTab:BaseButton;
        private var _teamTab:BaseButton;
        private var _groupTab:BaseButton;
        private var _channelList:HBox;
        private var _modeArr:Array;
        private var _hornHigh:int = 40;
        private var _curMode:int;
        private var _faceBtn:BaseButton;
        private var _type:int;
        private var _enterBtn:BaseButton;
        private var _roleName:String;
        private var _chatControl:ChatController;
        private var _privateRoleList:Array;
        private var _totalArr:LoopArray;
        private var _worldArr:LoopArray;
        private var _teamArr:LoopArray;
        private var _roleArr:LoopArray;
        private var _groupArr:LoopArray;
        private var _gmArr:LoopArray;
        private var _curArr:LoopArray;
        private var _stopAutoRoll:Boolean;
        private var _channelBtn:BaseButton;
        private var _bg:Sprite;
        private var _inputBg:Sprite;
        private var _outPut:ChatOutPut;
        private var _panelWidth:int;
        private var _panelHeight:int;
        private var _privateList:HBox;
        private var _chatRoleRect:ChatRoleRect;
        private var _lookObj:Object;
        private var _speakType:int;
        private var _roleFilter:Boolean;
        private var _teamFilter:Boolean;
        private var _groupFilter:Boolean;
        private var _recentList:Array;
        private var _recentIndex:int;
        public var inited:Boolean;
        private var _laba:LaBaView;
        private var _hornBtn:BaseButton;
        public var layout:LayoutInfo;
        private const OPERBAR_W:int = 974;
        private var _leftBtn:BaseButton;
        private var oldHeight:int;
        private var _transactionTab:BaseButton;
        private var _chatWarning:BaseSprite;
        private var _togap:int;
        private var _expandBtn:BaseButton;
        private var _forNextMsg:int;
        private var bmp:Bitmap;
        private var inShrink:Boolean = false;
        private var _inLeftTween:Boolean;
        private var _chatH:int;
        private var _lastLabaTime:int;
        private var _labaInfo:ChatInfo;

        public function ChatComponent()
        {
            this._modeArr = [0, 40, 160, 240, 384];
            setWH(ChatConst.CHAT_WIDTH, 51);
            this._roleArr = ChatModel.getInstance().roleArr;
            this._groupArr = ChatModel.getInstance().groupArr;
            this._teamArr = ChatModel.getInstance().teamArr;
            this._worldArr = ChatModel.getInstance().worldArr;
            this._totalArr = ChatModel.getInstance().totalArr;
            this.curArr = this._totalArr;
            this._recentList = [];
            this._speakType = ChatType.CHATTYPE_SCENE;
            this._type = ChatType.CHATTYPE_ALL;
            this._privateRoleList = [];
            this._chatControl = ChatController.getInstance();
            this._chatControl.chat = this;
            this._curMode = 2;
            this._lookObj = {label:LanguageCfgObj.getInstance().getByIndex("11959"), data:"_$*"};
            this.layout = new LayoutInfo();
            this._togap = this.OPERBAR_W * 0.5 - 220;
            loadDisplay("res/chat.swf");
            return;
        }// end function

        public function get groupFilter() : Boolean
        {
            return this._groupFilter;
        }// end function

        public function set groupFilter(param1:Boolean) : void
        {
            this._groupFilter = param1;
            if (param1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._groupTab);
                this._groupTab.alpha = 1;
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._groupTab);
            }
            return;
        }// end function

        public function get teamFilter() : Boolean
        {
            return this._teamFilter;
        }// end function

        public function set teamFilter(param1:Boolean) : void
        {
            this._teamFilter = param1;
            if (param1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._teamTab);
                this._teamTab.alpha = 1;
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._teamTab);
            }
            return;
        }// end function

        public function get roleFilter() : Boolean
        {
            return this._roleFilter;
        }// end function

        public function set roleFilter(param1:Boolean) : void
        {
            this._roleFilter = param1;
            if (param1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._roleTab);
                this._roleTab.alpha = 1;
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._roleTab);
            }
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get curArr() : LoopArray
        {
            return this._curArr;
        }// end function

        public function set curArr(param1:LoopArray) : void
        {
            var _loc_2:* = param1;
            this._curArr = param1;
            ChatModel.getInstance().curArr = _loc_2;
            return;
        }// end function

        public function get roleName() : String
        {
            return this._roleName;
        }// end function

        public function set roleName(param1:String) : void
        {
            if (this._chatRoleRect.parent)
            {
                this._roleName = param1;
                this._chatRoleRect.setText(this._roleName);
                stage.focus = this._input;
                this._input.setSelection(this._input.caretIndex, this._input.caretIndex);
            }
            return;
        }// end function

        private function getPlayerName(param1:String) : String
        {
            var _loc_2:* = param1.indexOf("]");
            return param1.substr((_loc_2 + 1));
        }// end function

        override protected function displayReady() : void
        {
            super.initComponentUI("chatComponent");
            this.initUI();
            this.addListener();
            this.inited = true;
            this.redecideMaxW();
            this.rebgsize(ChatConst.CHAT_WIDTH, _h);
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._outPut = new ChatOutPut(ChatConst.CHAT_WIDTH, 96);
            this._outPut.arr = ChatModel.getInstance().totalArr;
            display.addChildAt(this._outPut, 0);
            var _loc_1:* = 42;
            this._buttons = new Buttons();
            this._buttons.oneRow = 6;
            this._buttons.intervalX = 0;
            this._totalTab = new BaseButton("chatTabredenerer", true);
            this._totalTab.width = _loc_1;
            this._totalTab._w = _loc_1;
            this._totalTab.setText(LanguageCfgObj.getInstance().getByIndex("10442"));
            this._buttons.add(this._totalTab);
            this._worldTab = new BaseButton("chatTabredenerer", true);
            this._worldTab.width = _loc_1;
            this._worldTab._w = _loc_1;
            this._worldTab.setText(LanguageCfgObj.getInstance().getByIndex("10443"));
            this._buttons.add(this._worldTab);
            this._roleTab = new BaseButton("chatTabredenerer", true);
            this._roleTab.width = _loc_1;
            this._roleTab._w = _loc_1;
            this._roleTab.setText(LanguageCfgObj.getInstance().getByIndex("10444"));
            this._buttons.add(this._roleTab);
            this._teamTab = new BaseButton("chatTabredenerer", true);
            this._teamTab.width = _loc_1;
            this._teamTab._w = _loc_1;
            this._teamTab.setText(LanguageCfgObj.getInstance().getByIndex("10445"));
            this._buttons.add(this._teamTab);
            this._groupTab = new BaseButton("chatTabredenerer", true);
            this._groupTab.width = _loc_1;
            this._groupTab.setText(LanguageCfgObj.getInstance().getByIndex("10446"));
            this._groupTab._w = _loc_1;
            this._buttons.add(this._groupTab);
            this._transactionTab = new BaseButton("chatTabredenerer", true);
            this._transactionTab.width = _loc_1;
            this._transactionTab.setText(LanguageCfgObj.getInstance().getByIndex("10447"));
            this._transactionTab._w = _loc_1;
            this._buttons.add(this._transactionTab);
            this._buttons.move(19, 0);
            addChild(this._buttons);
            this._channelList = new HBox();
            this._channelList.intervalY = 0;
            this._expandBtn = new BaseButton(ToolKit.getNew("chat_expand_btn"));
            var _loc_2:* = this.createChannel();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = new SimpleItem();
                _loc_4.obj = _loc_2[_loc_3];
                this._channelList.add(_loc_4);
                _loc_3++;
            }
            this._channelList.x = 0;
            this._privateList = new HBox();
            this._privateList.intervalY = 2;
            this._upBtn = new BaseButton(getDisplayChildByName("btn_Up"));
            this._downBtn = new BaseButton(getDisplayChildByName("btn_Down"));
            this._enterBtn = new BaseButton(getDisplayChildByName("btn_enter"));
            this._faceBtn = new BaseButton(getDisplayChildByName("btn_face"));
            this._channelBtn = new BaseButton(getDisplayChildByName("btn_channel"));
            this._leftBtn = new BaseButton(getDisplayChildByName("btn_left"));
            this._channelBtn.setText(LanguageCfgObj.getInstance().getByIndex("10448"));
            this._channelList.y = _h - this._channelList.height - this._channelBtn.height - 5;
            this._channelList.x = this._channelBtn.x;
            this._inputBg = getDisplayChildByName("inputBg");
            this._bg = getDisplayChildByName("bg");
            this._input = new ChatInput();
            this._input.x = this._inputBg.x + 8;
            this._input.y = this._inputBg.y + 6;
            this._input.width = this._inputBg.width - 8;
            addChild(this._input);
            this.oldHeight = this._inputBg.y + this._inputBg.height;
            this._laba = new LaBaView(ChatConst.CHAT_WIDTH, 50);
            this._laba.y = this._outPut.y - this._laba.height;
            this._chatRoleRect = new ChatRoleRect("chatRoleRect");
            this._input.setDefault();
            StringTip.create(this._upBtn, LanguageCfgObj.getInstance().getByIndex("10449"));
            StringTip.create(this._downBtn, LanguageCfgObj.getInstance().getByIndex("10450"));
            this.setChannel();
            if (this._teamArr.length > 0)
            {
                this.teamFilter = true;
            }
            if (this._roleArr.length > 0)
            {
                this.roleFilter = true;
            }
            if (this._groupArr.length > 0)
            {
                this.groupFilter = true;
            }
            this._hornBtn = new BaseButton(ToolKit.getNew("horn_icon"));
            this._hornBtn.y = this._outPut.y - 40;
            this._hornBtn.x = 3;
            addChild(this._hornBtn);
            if (UserObj.getInstance().playerInfo.level < GlobalCfgObj.getInstance().getChatWarningLevel())
            {
                this._chatWarning = new BaseSprite();
                this._chatWarning.mouseChildren = false;
                this._chatWarning.mouseEnabled = false;
                _loc_5 = new Image();
                _loc_5.load("res/image/chatwarning.png", this.__warningComplete);
                this._chatWarning.addChild(_loc_5);
                Global.mainUIManager.addUI(this._chatWarning, null);
            }
            this.__out();
            return;
        }// end function

        private function __warningComplete(param1:BitmapData) : void
        {
            this.updateChatWarningLayout();
            return;
        }// end function

        public function updateChatWarningLayout() : void
        {
            var _loc_1:* = null;
            if (this._chatWarning)
            {
                _loc_1 = new LayoutInfo();
                _loc_1.type = Layout.NORMAL;
                _loc_1.offsetX = 0;
                _loc_1.offsetY = this.y + this._outPut.y - this._hornHigh - this._chatWarning.height;
                Global.mainUIManager.addUI(this._chatWarning, _loc_1);
            }
            return;
        }// end function

        override public function resize() : void
        {
            var _loc_1:* = getAttr("layoutInfo");
            if (_loc_1 == null)
            {
                _loc_1 = this.layout;
            }
            _loc_1.type = Layout.BOTTOM;
            _loc_1.offsetX = 0;
            var _loc_2:* = FrameworkGlobal.stageW * 0.5;
            var _loc_3:* = width == 0 ? (ChatConst.CHAT_WIDTH) : (width);
            if (_loc_3 + ChatConst.CHAT_HEIGHT_LEVEL[0] < _loc_2)
            {
                _loc_1.offsetY = 0;
            }
            else
            {
                _loc_1.offsetY = ChatConst.CHAT_HIGH[0];
            }
            this.layout = _loc_1;
            this.setAttr("layoutInfo", _loc_1);
            if (parent)
            {
                (parent as BaseSprite).layoutMC(this, _loc_1.type, _loc_1.offsetX, _loc_1.offsetY);
            }
            super.resize();
            this.updateChatWarningLayout();
            return;
        }// end function

        public function redecideMaxW() : void
        {
            var _loc_3:* = 0;
            var _loc_1:* = width == 0 ? (ChatConst.CHAT_WIDTH) : (width);
            var _loc_2:* = FrameworkGlobal.stageW * 0.5;
            if (_loc_1 + ChatConst.CHAT_HEIGHT_LEVEL[0] < _loc_2)
            {
                _loc_3 = _loc_2 - this.OPERBAR_W / 2;
            }
            else
            {
                _loc_3 = _loc_2 - this._togap;
            }
            _loc_1 = Math.min(FrameworkGlobal.stageW / 2 - this._togap, _loc_3) < ChatConst.CHAT_WIDTH ? (ChatConst.CHAT_WIDTH) : (Math.min(FrameworkGlobal.stageW / 2 - this._togap, _loc_3));
            this._outPut.MAXW = _loc_1;
            if (this._outPut.MAXW < this.width)
            {
                this._outPut.resizeByComponent(this._outPut.MAXW, this._chatH);
                this.rebgsize(this._outPut.MAXW, this._chatH);
            }
            return;
        }// end function

        private function createChannel() : Array
        {
            var _loc_3:* = null;
            var _loc_1:* = [];
            var _loc_2:* = ChatType.CHATTYPE_WORLD;
            while (_loc_2 <= ChatType.CHATTYPE_GM)
            {
                
                if (_loc_2 == ChatType.CHATTYPE_SYSTEM)
                {
                }
                else if (!Params.opengm && FrameworkGlobal.published && _loc_2 == ChatType.CHATTYPE_GM && !UserObj.getInstance().playerInfo.isGM())
                {
                }
                else
                {
                    _loc_3 = new Object();
                    _loc_3.label = this.createLabel(_loc_2);
                    _loc_3.data = _loc_2;
                    _loc_1.push(_loc_3);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function changeToRole(param1:String) : void
        {
            if (this._speakType != ChatType.CHATTYPE_ROLE)
            {
                this.changeType(ChatType.CHATTYPE_ROLE);
            }
            this.__over();
            this.roleName = param1;
            return;
        }// end function

        private function createLabel(param1:int) : String
        {
            return "<font color = \'#" + ChatType.getColor(param1).toString(16) + "\'>" + ChatType.getLabel(param1) + "</font>";
        }// end function

        private function addListener() : void
        {
            this._upBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._downBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._faceBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
            this._enterBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._channelList.addEvtListener(MouseEvent.MOUSE_DOWN, this.__listChange);
            this._buttons.addEvtListener(Event.CHANGE, this.__tabChange);
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            this._channelBtn.addEvtListener(MouseEvent.CLICK, this.__channelClick);
            this._outPut.addEvtListener(ChatEvent.RISIZE_CHAT, this.__resize);
            this._chatRoleRect.addEvtListener(ChatEvent.OPEN_PRIVATE_LIST, this.__openPrivate);
            this._privateList.addEvtListener(MouseEvent.MOUSE_DOWN, this.__privateChange);
            FrameworkGlobal.stageAddEvtListener(KeyboardEvent.KEY_DOWN, this.__key);
            this._chatRoleRect.addEvtListener(ChatEvent.NAME_CHANGE, this.__nameChange);
            this._hornBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._leftBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._expandBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            FrameworkGlobal.stage.addEventListener(Event.RESIZE, this.onResize);
            addEventListener(MouseEvent.CLICK, this.clickChatHandler);
            return;
        }// end function

        private function clickChatHandler(event:MouseEvent) : void
        {
            ToolKit.bringToTop(this);
            if (ChatModel.getInstance().inTextEvent)
            {
                return;
            }
            if (event.target is BaseButton || event.target == this._input || event.target == this._privateRoleList || event.target == this._channelList || event.target == this._chatRoleRect || event.target is TextField && event.target.parent is ChatLinkItem)
            {
                event.stopImmediatePropagation();
            }
            else
            {
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.CHAT_CLICK_BLANK, {x:event.stageX, y:event.stageY}));
            }
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this._expandBtn.parent)
            {
                _loc_3 = FrameworkGlobal.stageW * 0.5;
                _loc_4 = width == 0 ? (ChatConst.CHAT_WIDTH) : (width);
                if (_loc_4 + ChatConst.CHAT_HEIGHT_LEVEL[0] < _loc_3)
                {
                    _loc_2 = 0;
                }
                else
                {
                    _loc_2 = 158;
                }
                Global.mainUIManager.addUI(this._expandBtn, new LayoutInfo(Layout.BOTTOM, 0, _loc_2));
            }
            this.redecideMaxW();
            return;
        }// end function

        private function __nameChange(event:ChatEvent) : void
        {
            this._roleName = event.data.toString();
            return;
        }// end function

        private function __resize(event:ChatEvent) : void
        {
            this.rebgsize(event.data.w, event.data.h);
            return;
        }// end function

        private function __key(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case KeyCode.ENTER:
                {
                    if (!UserObj.keyable)
                    {
                        return;
                    }
                    if (stage.focus == this._input)
                    {
                        this.enter();
                    }
                    else if (!ToolKit.isInputTextField)
                    {
                        if (ChatController.getInstance().ischatActive())
                        {
                            this.__over();
                            stage.focus = this._input;
                        }
                    }
                    break;
                }
                case KeyCode.UP:
                {
                    if (stage.focus == this._input)
                    {
                        var _loc_2:* = this;
                        var _loc_3:* = this._recentIndex - 1;
                        _loc_2._recentIndex = _loc_3;
                        if (this._recentIndex < 0)
                        {
                            this._recentIndex = 0;
                        }
                        this._forNextMsg = setTimeout(this.setPre, 100);
                    }
                    break;
                }
                case KeyCode.DOWN:
                {
                    event.preventDefault();
                    if (stage.focus == this._input)
                    {
                        var _loc_2:* = this;
                        var _loc_3:* = this._recentIndex + 1;
                        _loc_2._recentIndex = _loc_3;
                        if (this._recentIndex > (this._recentList.length - 1))
                        {
                            this._recentIndex = this._recentList.length - 1;
                        }
                        this._forNextMsg = setTimeout(this.setPre, 100);
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

        public function addOutListener(param1:Boolean) : void
        {
            if (param1)
            {
                FrameworkGlobal.stageAddEvtListener(MouseEvent.MOUSE_MOVE, this.__out);
            }
            else
            {
                FrameworkGlobal.stageRemoveEvtListener(MouseEvent.MOUSE_MOVE, this.__out);
            }
            return;
        }// end function

        private function setPre() : void
        {
            clearTimeout(this._forNextMsg);
            if (this._recentList[this._recentIndex])
            {
                this._input.setMsg(this._recentList[this._recentIndex][0], this._recentList[this._recentIndex][1]);
            }
            return;
        }// end function

        public function addToFace(param1:String) : void
        {
            this.__over();
            this._input.addFace(param1);
            return;
        }// end function

        private function __openPrivate(event:ChatEvent) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = this._privateRoleList.concat(this._lookObj);
            var _loc_3:* = this._privateList.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this._privateList.removeByIndex(0);
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = new SimpleItem();
                _loc_5.width = 120;
                _loc_5.obj = _loc_2[_loc_4];
                this._privateList.add(_loc_5);
                _loc_4++;
            }
            this._privateList.x = this._chatRoleRect.x + (this._chatRoleRect.width - _loc_5.width) * 0.5 >> 0;
            this._privateList.y = this._chatRoleRect.y - this._privateList.height;
            addChild(this._privateList);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__privateDown, false, 0, true);
            return;
        }// end function

        private function __privateChange(event:Event) : void
        {
            var _loc_2:* = event.target as SimpleItem;
            if (_loc_2.obj.data == "_$*")
            {
                ChatController.getInstance().openLookList();
            }
            else
            {
                this.roleName = _loc_2.obj.label;
            }
            return;
        }// end function

        private function __privateDown(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__privateDown, false);
            if (this._privateList.parent)
            {
                this._privateList.parent.removeChild(this._privateList);
            }
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            var _loc_2:* = -2;
            switch(event.target.selectBtn)
            {
                case this._totalTab:
                {
                    _loc_2 = ChatType.CHATTYPE_ALL;
                    this.curArr = this._totalArr;
                    break;
                }
                case this._worldTab:
                {
                    _loc_2 = ChatType.CHATTYPE_WORLD;
                    this.curArr = this._worldArr;
                    break;
                }
                case this._roleTab:
                {
                    _loc_2 = ChatType.CHATTYPE_ROLE;
                    this.curArr = this._roleArr;
                    this.roleFilter = false;
                    break;
                }
                case this._teamTab:
                {
                    _loc_2 = ChatType.CHATTYPE_TEAM;
                    this.curArr = this._teamArr;
                    this.teamFilter = false;
                    break;
                }
                case this._groupTab:
                {
                    _loc_2 = ChatType.CHATTYPE_GROUP;
                    this.curArr = this._groupArr;
                    this.groupFilter = false;
                    break;
                }
                case this._transactionTab:
                {
                    this._type = ChatType.CHATTYPE_TRANSACTION;
                    this.curArr = ChatModel.getInstance().transactionArray;
                    this.setChannel();
                    return;
                }
                default:
                {
                    break;
                }
            }
            this.changeChanel(_loc_2);
            return;
        }// end function

        private function changeChanel(param1:int) : void
        {
            if (param1 != this._type)
            {
                this.setChannel();
            }
            this._type = param1;
            this.changeType(param1);
            return;
        }// end function

        private function changeType(param1:int) : void
        {
            this.setListType(param1);
            this.setMsgType(param1);
            return;
        }// end function

        private function assignActiveTime() : void
        {
            var _loc_1:* = getTimer();
            ChatController.getInstance().chat_active_time = _loc_1;
            return;
        }// end function

        private function __channelClick(event:MouseEvent) : void
        {
            addChild(this._channelList);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false, 0, true);
            return;
        }// end function

        private function __stageDown(event:MouseEvent) : void
        {
            if (this._channelList.parent)
            {
                this._channelList.parent.removeChild(this._channelList);
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            return;
        }// end function

        private function __byoundDown(event:MouseEvent) : void
        {
            var _loc_2:* = this.getBounds(this);
            if (!_loc_2.contains(mouseX, mouseY))
            {
                this.__out();
            }
            return;
        }// end function

        private function __outOver(event:MouseEvent) : void
        {
            this._outPut.stopAutoRoll = true;
            return;
        }// end function

        private function __outOut(event:MouseEvent) : void
        {
            this._outPut.stopAutoRoll = false;
            return;
        }// end function

        private function __over(event:MouseEvent = null) : void
        {
            this._outPut.over();
            this.assignActiveTime();
            this.setChatAlpha(1);
            FrameworkGlobal.stageAddEvtListener(MouseEvent.MOUSE_MOVE, this.__out);
            FrameworkGlobal.stageAddEvtListener(MouseEvent.MOUSE_DOWN, this.__byoundDown, false, true);
            return;
        }// end function

        private function setChatAlpha(param1:Number) : void
        {
            if (param1 != 1)
            {
                if (!this.teamFilter)
                {
                    this._teamTab.alpha = param1;
                }
                if (!this.roleFilter)
                {
                    this._roleTab.alpha = param1;
                }
                if (!this.groupFilter)
                {
                    this._groupTab.alpha = param1;
                }
            }
            else
            {
                this._teamTab.alpha = param1;
                this._roleTab.alpha = param1;
                this._groupTab.alpha = param1;
            }
            this._transactionTab.alpha = param1;
            this._hornBtn.alpha = param1;
            this._totalTab.alpha = param1;
            this._worldTab.alpha = param1;
            this._channelBtn.alpha = param1;
            var _loc_2:* = param1;
            this._downBtn.alpha = param1;
            this._upBtn.alpha = _loc_2;
            this._inputBg.alpha = _loc_2;
            this._bg.alpha = _loc_2;
            this._enterBtn.alpha = _loc_2;
            this._faceBtn.alpha = _loc_2;
            this._input.alpha = _loc_2;
            this._chatRoleRect.alpha = _loc_2;
            this._channelList.alpha = _loc_2;
            return;
        }// end function

        private function __out(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.getBounds(this);
            if (!_loc_2.contains(mouseX, mouseY) && FrameworkGlobal.stage.focus != this._input)
            {
                this._outPut.stopAutoRoll = false;
                this.setChatAlpha(0);
                FrameworkGlobal.stageRemoveEvtListener(MouseEvent.MOUSE_MOVE, this.__out);
                FrameworkGlobal.stageRemoveEvtListener(MouseEvent.MOUSE_DOWN, this.__byoundDown);
            }
            return;
        }// end function

        private function setChannel() : void
        {
            this._outPut.clear();
            this._outPut.addOutTxts(this.curArr);
            return;
        }// end function

        public function cue(param1:String) : void
        {
            var _loc_2:* = new ChatInfo();
            _loc_2.chattype = ChatType.CHATTYPE_SYSTEM;
            _loc_2.condition = param1;
            _loc_2.parse();
            this.accept(_loc_2);
            return;
        }// end function

        private function setListType(param1:int) : void
        {
            this._channelBtn.setText(this.getBtnLabel(param1));
            return;
        }// end function

        private function getBtnLabel(param1:int) : String
        {
            if (param1 == ChatType.CHATTYPE_ALL)
            {
                return (this._channelList.getContent(1) as SimpleItem).obj.label;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._channelList.length)
            {
                
                if ((this._channelList.getContent(_loc_2) as SimpleItem).obj.data == param1)
                {
                    return (this._channelList.getContent(_loc_2) as SimpleItem).obj.label;
                }
                _loc_2++;
            }
            return "";
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._upBtn:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._curMode + 1;
                    _loc_2._curMode = _loc_3;
                    if (this._curMode > 4)
                    {
                        this._curMode = 4;
                    }
                    this._outPut.changeMode(this._modeArr[this._curMode]);
                    this._laba.y = this._outPut.y - this._laba.getHeight();
                    this._hornBtn.y = this._outPut.y - this._hornHigh;
                    this.updateChatWarningLayout();
                    break;
                }
                case this._downBtn:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._curMode - 1;
                    _loc_2._curMode = _loc_3;
                    if (this._curMode < 0)
                    {
                        this._curMode = 0;
                    }
                    this._outPut.changeMode(this._modeArr[this._curMode]);
                    this._laba.y = this._outPut.y - this._laba.getHeight();
                    this._hornBtn.y = this._outPut.y - this._hornHigh;
                    this.updateChatWarningLayout();
                    break;
                }
                case this._enterBtn:
                {
                    this.enter();
                    break;
                }
                case this._faceBtn:
                {
                    event.stopImmediatePropagation();
                    if (this._channelList && this._channelList.parent)
                    {
                        this._channelList.parent.removeChild(this._channelList);
                    }
                    this._chatControl.openFace();
                    break;
                }
                case this._hornBtn:
                {
                    ChatController.getInstance().openHorn();
                    break;
                }
                case this._leftBtn:
                {
                    this.shrink();
                    break;
                }
                case this._expandBtn:
                {
                    this.expand();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function shrink() : void
        {
            this.inShrink = true;
            ToolKit.disappear(this.bmp);
            this.bmp = new Bitmap();
            var _loc_1:* = new BitmapData(this._bg.width, this._chatH, true, 0);
            _loc_1.draw(this);
            this.bmp.bitmapData = _loc_1;
            addChild(this.bmp);
            mouseEnabled = false;
            mouseChildren = false;
            if (this._chatWarning)
            {
                this._chatWarning.visible = false;
            }
            if (this._laba && !this._labaInfo)
            {
                this._laba.shrink();
            }
            TweenLite.to(this, 0.2, {scaleX:0.1, scaleY:0.1, y:y + this._inputBg.y + this._inputBg.height, onComplete:this.shrinkComp});
            return;
        }// end function

        private function shrinkComp() : void
        {
            var _loc_1:* = 0;
            mouseEnabled = true;
            mouseChildren = true;
            visible = false;
            if (this.bmp && this.bmp.parent)
            {
                this.bmp.parent.removeChild(this.bmp);
            }
            var _loc_2:* = FrameworkGlobal.stageW * 0.5;
            var _loc_3:* = _w == 0 ? (ChatConst.CHAT_WIDTH) : (_w);
            if (_loc_3 + ChatConst.CHAT_HEIGHT_LEVEL[0] < _loc_2)
            {
                _loc_1 = 0;
            }
            else
            {
                _loc_1 = ChatConst.CHAT_HIGH[0];
            }
            Global.mainUIManager.addUI(this._expandBtn, new LayoutInfo(Layout.BOTTOM, 0, _loc_1));
            return;
        }// end function

        private function expand() : void
        {
            var _loc_2:* = 0;
            ToolKit.disappear(this.bmp);
            this.bmp = new Bitmap();
            var _loc_1:* = new BitmapData(this._bg.width, this._chatH, true, 0);
            _loc_1.draw(this);
            this.bmp.bitmapData = _loc_1;
            addChild(this.bmp);
            mouseEnabled = false;
            mouseChildren = false;
            visible = true;
            var _loc_3:* = FrameworkGlobal.stageW * 0.5;
            var _loc_4:* = _w == 0 ? (ChatConst.CHAT_WIDTH) : (_w);
            if ((_w == 0 ? (ChatConst.CHAT_WIDTH) : (_w)) + ChatConst.CHAT_HEIGHT_LEVEL[0] < _loc_3)
            {
                _loc_2 = 0;
            }
            else
            {
                _loc_2 = ChatConst.CHAT_HIGH[0];
            }
            var _loc_5:* = FrameworkGlobal.stageH - this.oldHeight - _loc_2;
            TweenLite.to(this, 0.2, {scaleX:1, scaleY:1, y:_loc_5, onComplete:this.expandComp});
            return;
        }// end function

        private function expandComp() : void
        {
            mouseEnabled = true;
            mouseChildren = true;
            this._outPut.repaint();
            if (this._lastLabaTime != 0)
            {
                this.reshowLaba();
            }
            if (this._chatWarning)
            {
                this._chatWarning.visible = true;
            }
            this.inShrink = false;
            if (this.bmp && this.bmp.parent)
            {
                this.bmp.parent.removeChild(this.bmp);
            }
            Global.mainUIManager.removeUI(this._expandBtn);
            return;
        }// end function

        private function leftOver() : void
        {
            this._inLeftTween = false;
            return;
        }// end function

        private function enter() : void
        {
            var _loc_1:* = null;
            if (!this._input.isDefault)
            {
                if (this._speakType != ChatType.CHATTYPE_GM)
                {
                    this.sendMsg();
                }
                else
                {
                    _loc_1 = this._input.getMsg();
                    this._chatControl.toGm(_loc_1[0]);
                    this._recentList.push(_loc_1);
                    this._recentIndex = this._recentList.length;
                    this._input.clear();
                }
            }
            return;
        }// end function

        private function rebgsize(param1:int, param2:int) : void
        {
            this._chatH = param2;
            this._laba.y = this._outPut.y - this._laba.getHeight();
            this._hornBtn.y = this._outPut.y - this._hornHigh;
            this._upBtn.x = param1 - this._upBtn.width;
            this._downBtn.x = param1 - 2 * this._upBtn.width;
            this._enterBtn.x = param1 - this._enterBtn.width;
            this._faceBtn.x = this._enterBtn.x - this._faceBtn.width;
            this._inputBg.width = this._faceBtn.x - this._inputBg.x;
            this._bg.width = param1;
            this.updateChatWarningLayout();
            if (this._type != ChatType.CHATTYPE_ROLE)
            {
                this._input.x = this._inputBg.x + 8;
                this._input.width = this._inputBg.width - 8;
            }
            else
            {
                this._input.x = this._inputBg.x + this._chatRoleRect.width + 8;
                this._input.width = this._inputBg.width - this._chatRoleRect.width - 8;
            }
            return;
        }// end function

        private function __listChange(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as SimpleItem;
            if (_loc_2)
            {
                this._channelBtn.setText(_loc_2.label);
                this.setMsgType(_loc_2.obj.data);
                event.stopPropagation();
                if (this._channelList.parent)
                {
                    this._channelList.parent.removeChild(this._channelList);
                }
                FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            }
            return;
        }// end function

        private function setMsgType(param1:int) : void
        {
            if (param1 == ChatType.CHATTYPE_ALL)
            {
                this._speakType = ChatType.CHATTYPE_SCENE;
            }
            else
            {
                this._speakType = param1;
            }
            if (this._speakType == ChatType.CHATTYPE_ROLE)
            {
                if (this._chatRoleRect.parent == null)
                {
                    this._chatRoleRect.x = this._inputBg.x;
                    this._chatRoleRect.y = this._inputBg.y + 4;
                    addChild(this._chatRoleRect);
                    this._input.x = this._inputBg.x + this._chatRoleRect.width + 8;
                    this._input.width = this._inputBg.width - this._chatRoleRect.width - 8;
                }
            }
            else if (this._chatRoleRect.parent != null)
            {
                this._chatRoleRect.parent.removeChild(this._chatRoleRect);
                this._input.x = this._inputBg.x + 8;
                this._input.width = this._inputBg.width - 8;
            }
            this.assignActiveTime();
            this.setForcus(this._speakType);
            return;
        }// end function

        private function setForcus(param1:int) : void
        {
            if (!stage)
            {
                return;
            }
            return;
        }// end function

        public function addFace(param1:FaceSp) : void
        {
            param1.x = this._faceBtn.x;
            param1.y = this._faceBtn.y - param1.height - 2;
            param1.position = 0;
            addChild(param1);
            return;
        }// end function

        private function sendLaBa() : void
        {
            var _loc_1:* = this._input.getMsg();
            var _loc_2:* = _loc_1[0];
            var _loc_3:* = _loc_1[1];
            this._chatControl.chatRquest(this._speakType, _loc_2, this._roleName, _loc_3);
            this._recentList.push(_loc_1);
            ChatModel.getInstance().preTimer[this._speakType] = getTimer();
            this._recentIndex = this._recentList.length;
            this._input.clear();
            return;
        }// end function

        private function sendMsg() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_1:* = getTimer();
            if (ChatModel.getInstance().preTimer[this._speakType] == 0 || _loc_1 - ChatModel.getInstance().preTimer[this._speakType] > ChatModel.getInteralTime(this._speakType))
            {
                if (this._speakType == ChatType.CHATTYPE_HORN)
                {
                    BackPackControl.getInstance().checkItemCount(ItemConst.HORN, 1, this.sendLaBa, null, ConfirmObj.CHAT_LABA);
                    return;
                }
                _loc_2 = this._input.getMsg();
                _loc_3 = _loc_2[0];
                _loc_4 = _loc_2[1];
                if (_loc_3.length == 0 && _loc_4.length == 0)
                {
                    return;
                }
                if (this._speakType == ChatType.CHATTYPE_ROLE)
                {
                    if (this._roleName != "" && this._roleName != null)
                    {
                        if (this._roleName == UserObj.getInstance().playerInfo.name)
                        {
                            ChatController.getInstance().addtoCue(LanguageCfgObj.getInstance().getByIndex("10451"), [ChatType.CHATTYPE_SYSTEM, ChatType.CHATTYPE_ROLE]);
                            return;
                        }
                        _loc_5 = false;
                        _loc_6 = 0;
                        while (_loc_6 < this._privateRoleList.length)
                        {
                            
                            if (this._privateRoleList[_loc_6].label == this._roleName)
                            {
                                _loc_5 = true;
                                break;
                            }
                            _loc_6++;
                        }
                        if (!_loc_5)
                        {
                            this._privateRoleList.push({label:this._roleName, data:this._roleName});
                        }
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10452"));
                        return;
                    }
                }
                else if (this._speakType == ChatType.CHATTYPE_TEAM)
                {
                    if (!UserObj.getInstance().playerInfo.teamId || UserObj.getInstance().playerInfo.teamId.high == 0 && UserObj.getInstance().playerInfo.teamId.low == 0)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10453"));
                        return;
                    }
                }
                else if (this._speakType == ChatType.CHATTYPE_GROUP)
                {
                    if (!UserObj.getInstance().playerInfo.guildId || UserObj.getInstance().playerInfo.guildId.high == 0 && UserObj.getInstance().playerInfo.guildId.low == 0)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10454"));
                        return;
                    }
                }
                this._recentList.push(_loc_2);
                this._recentIndex = this._recentList.length;
                this._chatControl.chatRquest(this._speakType, _loc_3, this._roleName, _loc_4);
                ChatModel.getInstance().preTimer[this._speakType] = _loc_1;
                this._input.clear();
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10455"));
            }
            return;
        }// end function

        public function linkToChat(param1:PropInfo) : void
        {
            this.__over();
            this._input.accept(param1);
            return;
        }// end function

        private function flicker(param1:int) : void
        {
            if (param1 != this._type)
            {
                switch(param1)
                {
                    case ChatType.CHATTYPE_GROUP:
                    {
                        this.groupFilter = true;
                        break;
                    }
                    case ChatType.CHATTYPE_TEAM:
                    {
                        this.teamFilter = true;
                        break;
                    }
                    case ChatType.CHATTYPE_ROLE:
                    {
                        this.roleFilter = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function addCue(param1:ChatInfo) : void
        {
            if (this._outPut)
            {
                if (param1.chattype == ChatType.CHATTYPE_SYSTEM && this._type == ChatType.CHATTYPE_ALL)
                {
                    this._outPut.addOutTxt(param1);
                }
                else if (this._type == param1.chattype)
                {
                    this._outPut.addOutTxt(param1);
                }
                this.flicker(param1.chattype);
            }
            return;
        }// end function

        public function accept(param1:ChatInfo) : void
        {
            if (this._outPut)
            {
                if (this._type == param1.chattype || this._type == ChatType.CHATTYPE_ALL)
                {
                    this._outPut.addOutTxt(param1);
                }
                this.flicker(param1.chattype);
            }
            return;
        }// end function

        public function clearLabaInfo() : void
        {
            this._labaInfo = null;
            return;
        }// end function

        public function reshowLaba() : void
        {
            var _loc_1:* = 0;
            if (this._laba)
            {
                _loc_1 = this._laba.reshow(this._labaInfo, this._lastLabaTime);
                if (_loc_1 == 0)
                {
                    this.clearLabaInfo();
                }
                this._lastLabaTime = 0;
            }
            return;
        }// end function

        public function paintLaBa(param1:ChatInfo) : void
        {
            var _loc_2:* = null;
            if (this._laba)
            {
                this._labaInfo = param1;
                if (!this.inShrink)
                {
                    this._laba.info = param1;
                    this._lastLabaTime = 0;
                }
                else
                {
                    this._lastLabaTime = getTimer();
                }
                TweenLite.to(this._laba, 0.3, {alpha:1, onComplete:this.laBaComplete});
                this._laba.y = this._outPut.y - this._laba.getHeight();
                if (this._hornBtn && this._hornBtn.parent)
                {
                    this._hornBtn.parent.removeChild(this._hornBtn);
                }
                _loc_2 = FaceSp.instance;
                if (_loc_2.parent)
                {
                    addChildAt(this._laba, (numChildren - 1));
                }
                else
                {
                    addChildAt(this._laba, numChildren);
                }
            }
            return;
        }// end function

        public function laBaComplete() : void
        {
            return;
        }// end function

        private function disappear() : void
        {
            TweenLite.to(this._laba, 0.3, {alpha:0, onComplete:this.laBaEnd});
            return;
        }// end function

        private function laBaEnd() : void
        {
            if (this._laba && this._laba.parent)
            {
                this._laba.parent.removeChild(this._laba);
            }
            return;
        }// end function

        private function removeListener() : void
        {
            this._upBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._downBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._faceBtn.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
            this._enterBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._channelList.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__listChange);
            this._buttons.removeEvtListener(Event.CHANGE, this.__tabChange);
            this._outPut.removeEvtListener(MouseEvent.ROLL_OVER, this.__over);
            this._outPut.removeEvtListener(MouseEvent.ROLL_OUT, this.__out);
            this._channelBtn.removeEvtListener(MouseEvent.CLICK, this.__channelClick);
            this._outPut.removeEvtListener(ChatEvent.RISIZE_CHAT, this.__resize);
            this._chatRoleRect.removeEvtListener(ChatEvent.OPEN_PRIVATE_LIST, this.__openPrivate);
            this._privateList.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__privateChange);
            FrameworkGlobal.stageRemoveEvtListener(KeyboardEvent.KEY_DOWN, this.__key);
            this._chatRoleRect.removeEvtListener(ChatEvent.NAME_CHANGE, this.__nameChange);
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            this.removeListener();
            this._teamArr = null;
            this._buttons.finalize();
            this._chatRoleRect = null;
            this.parent.removeChild(this);
            return;
        }// end function

    }
}
