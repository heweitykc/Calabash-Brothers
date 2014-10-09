package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guild.control.*;
    import com.model.*;
    import flash.events.*;

    public class GuildBox extends BaseBox
    {
        private var _guildInfoView:GuildInfoView;
        private var _guildDevelopView:GuildDevelopView;
        private var _guildEventView:GuildEventView;
        private var _guildListView:GuildListView;
        private var closeBtn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var _type:int = 1;
        private var btnAry:Array;
        private var viewAry:Array;

        public function GuildBox()
        {
            this.btnAry = [];
            this.viewAry = [];
            _peaceBox = ["*"];
            loadDisplay("res/guildbox.swf");
            return;
        }// end function

        public function get btn() : BaseButton
        {
            return this.btn1;
        }// end function

        public function get guildInfoView() : GuildInfoView
        {
            if (!this._guildInfoView)
            {
                this._guildInfoView = new GuildInfoView();
                addChild(this._guildInfoView);
                this.viewAry[0] = this._guildInfoView;
            }
            return this._guildInfoView;
        }// end function

        public function get guildDevelopView() : GuildDevelopView
        {
            if (!this._guildDevelopView)
            {
                this._guildDevelopView = new GuildDevelopView();
                addChild(this._guildDevelopView);
                this.viewAry[1] = this._guildDevelopView;
            }
            return this._guildDevelopView;
        }// end function

        public function get guildEventView() : GuildEventView
        {
            if (!this._guildEventView)
            {
                this._guildEventView = new GuildEventView();
                addChild(this._guildEventView);
                this.viewAry[3] = this._guildEventView;
            }
            return this._guildEventView;
        }// end function

        public function get guildListView() : GuildListView
        {
            if (!this._guildListView)
            {
                this._guildListView = new GuildListView();
                addChild(this._guildListView);
                this.viewAry[4] = this._guildListView;
            }
            return this._guildListView;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn5 = new BaseButton(getDisplayChildByName("btn5"));
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn2.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn3.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn4.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn5.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10766"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10767"));
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("10768"));
            this.btn3.visible = false;
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("10769"));
            this.btn5.setText(LanguageCfgObj.getInstance().getByIndex("10770"));
            this.btnAry.push(this.btn1);
            this.btnAry.push(this.btn2);
            this.btnAry.push(this.btn3);
            this.btnAry.push(this.btn4);
            this.btnAry.push(this.btn5);
            this.btnAry[0].selected = true;
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.choose(this._type);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            if (this._type == (_loc_2 + 1))
            {
                return;
            }
            if (_loc_2 == 2)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10771"));
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.btnAry.length)
            {
                
                if (this.btnAry[_loc_3] == event.target)
                {
                    this.btnAry[_loc_3].selected = true;
                    if (this.viewAry[_loc_3])
                    {
                        addChild(this.viewAry[_loc_3]);
                    }
                }
                else
                {
                    this.btnAry[_loc_3].selected = false;
                    if (this.viewAry[_loc_3] && this.viewAry[_loc_3].parent)
                    {
                        removeChild(this.viewAry[_loc_3]);
                    }
                }
                _loc_3++;
            }
            this._type = _loc_2 + 1;
            this.choose(this._type);
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.choose(this._type);
            }
            return;
        }// end function

        private function choose(param1:int = 1) : void
        {
            switch(param1)
            {
                case 1:
                {
                    this.guildInfoView.reset();
                    this.guildInfoView.update();
                    break;
                }
                case 2:
                {
                    this.guildDevelopView.update();
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    GuildControl.getInstance().reqGuildGetEventList(UserObj.getInstance().playerInfo.guildId);
                    this.guildEventView.update();
                    break;
                }
                case 5:
                {
                    GuildListView.curPage = 1;
                    GuildControl.getInstance().reqGuildList();
                    this.guildListView.clear();
                    this.guildListView.update();
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
