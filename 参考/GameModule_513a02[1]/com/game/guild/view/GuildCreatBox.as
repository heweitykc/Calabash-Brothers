package com.game.guild.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guild.control.*;
    import com.game.guild.model.*;
    import flash.events.*;

    public class GuildCreatBox extends BaseBox
    {
        private var _guildCreatView:GuildCreatPannel;
        private var _guildApplyView:GuildApplyView;
        private var closeBtn:BaseButton;
        private var btn_creat:BaseButton;
        private var btn_apply:BaseButton;
        private var check_btn:BaseButton;
        private var _type:int = 2;
        private var btnAry:Array;
        private var viewAry:Array;

        public function GuildCreatBox()
        {
            this.btnAry = [];
            this.viewAry = [];
            _peaceBox = ["*"];
            loadDisplay("res/createguildbox.swf");
            return;
        }// end function

        public function get btnCreat() : BaseButton
        {
            return this.btn_creat;
        }// end function

        public function get guildCreatView() : GuildCreatPannel
        {
            if (!this._guildCreatView)
            {
                this._guildCreatView = new GuildCreatPannel();
                addChild(this._guildCreatView);
                this.viewAry[0] = this._guildCreatView;
            }
            return this._guildCreatView;
        }// end function

        public function get guildApplyView() : GuildApplyView
        {
            if (!this._guildApplyView)
            {
                this._guildApplyView = new GuildApplyView();
                addChild(this._guildApplyView);
                this.viewAry[1] = this._guildApplyView;
            }
            return this._guildApplyView;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildCreat");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_creat = new BaseButton(getDisplayChildByName("btn_creat"));
            this.btn_apply = new BaseButton(getDisplayChildByName("btn_apply"));
            this.btn_creat.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_creat.setText(LanguageCfgObj.getInstance().getByIndex("10776"));
            this.btn_apply.setText(LanguageCfgObj.getInstance().getByIndex("10777"));
            this.btnAry.push(this.btn_creat);
            this.btnAry.push(this.btn_apply);
            this.btnAry[0].selected = true;
            this.check_btn = new BaseButton(getDisplayChildByName("check_btn"), true);
            this.check_btn.selected = false;
            this.check_btn.setText(LanguageCfgObj.getInstance().getByIndex("10778"));
            GuildControl.getInstance().reqGuildAutoArgeeAddGuild(0);
            this.check_btn.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
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

        private function __click2(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.check_btn:
                {
                    GuildData.getInstance().isAutoAgreeAddGuild = this.check_btn.selected;
                    GuildControl.getInstance().reqGuildAutoArgeeAddGuild(this.check_btn.selected ? (1) : (0));
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
                    this.guildCreatView.update();
                    break;
                }
                case 2:
                {
                    GuildApplyView.curPage = 1;
                    GuildControl.getInstance().reqGuildList();
                    this.guildApplyView.clear();
                    this.guildApplyView.update();
                    break;
                }
                case 3:
                {
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
