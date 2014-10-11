package com.game.chat.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.guild.control.*;
    import com.game.player.control.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ChatSearchList extends BaseBox
    {
        private var _nameBtn:BaseButton;
        private var _levelBtn:BaseButton;
        private var _searchBtn:BaseButton;
        private var _infoBtn:BaseButton;
        private var _chatBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _input_txt:TextField;
        private var _holderSp:Sprite;
        private var _list:Array;
        private var _curList:Array;
        private var _itemList:List;
        private const TEMPLATE:String;
        private var _type:int = 1;
        private var _preTimer:int;
        public static const CHAT:int = 1;
        public static const GUILD:int = 2;

        public function ChatSearchList(param1 = null, param2:uint = 40, param3:String = "", param4:Boolean = true)
        {
            this.TEMPLATE = "<font color = \'#ffd47f\'>" + LanguageCfgObj.getInstance().getByIndex("11684") + "</font>";
            super(param1, param2, param3, param4);
            this.initUI();
            this.addListener();
            ChatController.getInstance().chatList = this;
            this._list = [];
            return;
        }// end function

        public function get list() : Array
        {
            return this._list;
        }// end function

        public function set list(param1:Array) : void
        {
            this._list = param1;
            this._curList = this._list;
            this.update();
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

        private function initUI() : void
        {
            this._nameBtn = new BaseButton(getDisplayChildByName("btn_name"));
            this._levelBtn = new BaseButton(getDisplayChildByName("btn_level"));
            this._searchBtn = new BaseButton(getDisplayChildByName("btn_search"));
            this._infoBtn = new BaseButton(getDisplayChildByName("btn_info"));
            this._chatBtn = new BaseButton(getDisplayChildByName("btn_chat"));
            this._closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this._searchBtn.setText(LanguageCfgObj.getInstance().getByIndex("10460"));
            this._infoBtn.setText(LanguageCfgObj.getInstance().getByIndex("10461"));
            this._chatBtn.setText(LanguageCfgObj.getInstance().getByIndex("10462"));
            this._holderSp = getDisplayChildByName("txt_holder");
            this._itemList = new List(304, 136);
            this._itemList.selectable = true;
            this._itemList.oneRow = 1;
            this._itemList.move(10, 99);
            addChild(this._itemList);
            this._itemList.cellRenderer = ChatItem;
            this._itemList.scrollBarLeft(false);
            this._input_txt = getDisplayChildByName("txtSearchKey");
            return;
        }// end function

        private function addListener() : void
        {
            this._nameBtn.addEvtListener(MouseEvent.CLICK, this.__mouseClick);
            this._levelBtn.addEvtListener(MouseEvent.CLICK, this.__mouseClick);
            this._searchBtn.addEvtListener(MouseEvent.CLICK, this.__mouseClick);
            this._infoBtn.addEvtListener(MouseEvent.CLICK, this.__mouseClick);
            this._chatBtn.addEvtListener(MouseEvent.CLICK, this.__mouseClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._input_txt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            addEvtListener(Event.ADDED_TO_STAGE, this.__addToStage);
            return;
        }// end function

        private function __keyDownHandler(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case KeyCode.ENTER:
                {
                    if (FrameworkGlobal.stage.focus == this._input_txt)
                    {
                        if (this._input_txt.text == "" || this._input_txt.text == null || this._input_txt.text.indexOf(LanguageCfgObj.getInstance().getByIndex("11684")) != -1)
                        {
                            this.query();
                        }
                        else
                        {
                            this.search();
                        }
                        this._input_txt.htmlText = this.TEMPLATE;
                    }
                    FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __addToStage(event:Event) : void
        {
            this._input_txt.htmlText = this.TEMPLATE;
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            this._input_txt.text = "";
            this._input_txt.textColor = 16635261;
            this._input_txt.removeEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
        }// end function

        private function __focusOut(event:FocusEvent) : void
        {
            this._input_txt.htmlText = this.TEMPLATE;
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            FrameworkGlobal.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            return;
        }// end function

        public function query() : void
        {
            if (!ChatController.getInstance().query(this._type))
            {
                this._curList = this.list;
                this.update();
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.updateUI();
            this.query();
            this._input_txt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            FrameworkGlobal.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            return;
        }// end function

        private function updateUI() : void
        {
            switch(this._type)
            {
                case CHAT:
                {
                    this._chatBtn.setText(LanguageCfgObj.getInstance().getByIndex("10462"));
                    break;
                }
                case GUILD:
                {
                    this._chatBtn.setText(LanguageCfgObj.getInstance().getByIndex("10464"));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __mouseClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._nameBtn:
                {
                    break;
                }
                case this._levelBtn:
                {
                    this.sort();
                    break;
                }
                case this._searchBtn:
                {
                    if (this._input_txt.text == "" || this._input_txt.text == null || this._input_txt.text.indexOf(LanguageCfgObj.getInstance().getByIndex("11684")) != -1)
                    {
                        this.query();
                    }
                    else
                    {
                        this.search();
                    }
                    this._input_txt.htmlText = this.TEMPLATE;
                    this._input_txt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
                    FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
                    break;
                }
                case this._infoBtn:
                {
                    if (this._itemList.selectItem)
                    {
                        PlayerControl.getInstance().reqForPlayer(this._itemList.selectItem.obj.id);
                        this.close();
                    }
                    break;
                }
                case this._chatBtn:
                {
                    switch(this._type)
                    {
                        case CHAT:
                        {
                            if (this._itemList.selectItem)
                            {
                                this.close();
                                ChatController.getInstance().toRole(this._itemList.selectItem.obj.name);
                            }
                            else
                            {
                                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10465"));
                            }
                            break;
                        }
                        case GUILD:
                        {
                            if (this._itemList.selectItem)
                            {
                                this.close();
                                GuildControl.getInstance().reqGuildInviteAdd(UserObj.getInstance().playerInfo.personId, this._itemList.selectItem.obj.id);
                            }
                            else
                            {
                                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10466"));
                            }
                            break;
                        }
                        default:
                        {
                            break;
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

        private function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._preTimer < 200)
            {
                this._preTimer = 0;
                if (this._itemList.selectItem)
                {
                    this.close();
                    ChatController.getInstance().toRole(this._itemList.selectItem.obj.name);
                }
            }
            else
            {
                this._preTimer = _loc_2;
            }
            return;
        }// end function

        private function search() : void
        {
            var _loc_1:* = StringUtil.trim(this._input_txt.text);
            ChatController.getInstance().queryName(_loc_1);
            return;
        }// end function

        private function sort() : void
        {
            this._curList.sortOn("level", Array.NUMERIC | Array.DESCENDING);
            this.update();
            return;
        }// end function

        private function update() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = this._curList.length;
            var _loc_2:* = _loc_1 - this._itemList.length;
            if (_loc_2 > 0)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    this._itemList.addObj(this._curList[_loc_3]);
                    _loc_3++;
                }
            }
            else if (_loc_2 < 0)
            {
                _loc_2 = -_loc_2;
                _loc_4 = this._itemList.length;
                _loc_3 = _loc_4 - 1;
                while (_loc_3 >= _loc_4 - _loc_2)
                {
                    
                    this._itemList.removeItem(this._itemList.getContent(_loc_3));
                    _loc_3 = _loc_3 - 1;
                }
            }
            _loc_1 = this._itemList.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_1)
            {
                
                this._itemList.getContent(_loc_3).obj = this._curList[_loc_3];
                this._itemList.getContent(_loc_3).addEvtListener(MouseEvent.CLICK, this.__click);
                _loc_3++;
            }
            this._itemList.scrollBarLeft(false);
            this._itemList.updateThumb();
            return;
        }// end function

    }
}
