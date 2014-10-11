package com.game.team.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.player.control.*;
    import com.game.team.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class TeamInvitePanel extends BaseBox
    {
        private var btnScan:BaseButton;
        private var btnInvite:BaseButton;
        private var btnSearch:BaseButton;
        private var btnClose:BaseButton;
        private var txtSearchKey:TextField;
        private var delayHandler:uint;
        private var isCanSearch:Boolean = true;
        private var playerList:List;
        private var selectItem:TeamInviteItem;
        private var vecItemList:Vector.<TeamInviteItem>;

        public function TeamInvitePanel()
        {
            this.vecItemList = new Vector.<TeamInviteItem>;
            super("teamInviteView");
            this.initPanel();
            return;
        }// end function

        private function initPanel() : void
        {
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.btnScan = new BaseButton(getDisplayChildByName("btnScan"));
            this.btnScan.setText(LanguageCfgObj.getInstance().getByIndex("11348"));
            this.btnInvite = new BaseButton(getDisplayChildByName("btnInvite"));
            this.btnInvite.setText(LanguageCfgObj.getInstance().getByIndex("11349"));
            this.btnSearch = new BaseButton(getDisplayChildByName("btnSearch"));
            this.btnSearch.setText(LanguageCfgObj.getInstance().getByIndex("11350"));
            this.txtSearchKey = getDisplayChildByName("txtSearchKey");
            this.playerList = new List(254, 280);
            this.addChild(this.playerList);
            this.playerList.move(11, 117);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.target is TeamInviteItem)
            {
                this.clickItem(event.target as TeamInviteItem);
                return;
            }
            switch(event.target)
            {
                case this.btnScan:
                {
                    this.scanPlayer();
                    break;
                }
                case this.btnInvite:
                {
                    this.InvitePlayer();
                    break;
                }
                case this.btnSearch:
                {
                    _loc_2 = this.txtSearchKey.text;
                    this.searchPlayer(_loc_2);
                    break;
                }
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.txtSearchKey:
                {
                    this.txtSearchKey.setSelection(0, _loc_2.length);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function scanPlayer() : void
        {
            if (!this.selectItem)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11351"));
                return;
            }
            var _loc_1:* = this.selectItem;
            var _loc_2:* = _loc_1.info.playerid;
            PlayerControl.getInstance().reqForPlayer(_loc_2);
            return;
        }// end function

        private function clickItem(param1:TeamInviteItem) : void
        {
            if (this.selectItem)
            {
                this.selectItem.selected = false;
            }
            this.selectItem = param1;
            param1.selected = true;
            return;
        }// end function

        public function updatePlayerList(param1:Vector.<MapPlayerInfo>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = param1.length;
            while (this.vecItemList.length > 0)
            {
                
                this.vecItemList.pop();
            }
            this.playerList.reset();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = new TeamInviteItem();
                _loc_2.index = _loc_4 + 1;
                this.vecItemList.push(_loc_2);
                _loc_2.info = param1[_loc_4];
                _loc_2.mouseChildren = false;
                this.playerList.add(_loc_2);
                _loc_4++;
            }
            return;
        }// end function

        public function setSearchResult(param1:Vector.<TeamMemberInfo>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.vecItemList.length > 0)
            {
                _loc_2 = 0;
                while (_loc_2 < param1.length)
                {
                    
                    _loc_3 = 0;
                    while (_loc_3 < this.vecItemList.length)
                    {
                        
                        if (param1[_loc_2].memberid.equal(this.vecItemList[_loc_3].info.playerid))
                        {
                            this.vecItemList[_loc_3].hasTeam = true;
                        }
                        _loc_3++;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function InvitePlayer() : void
        {
            if (!this.selectItem)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11351"));
                return;
            }
            var _loc_1:* = this.selectItem;
            var _loc_2:* = _loc_1.info.playerid;
            var _loc_3:* = TeamModel.getInstance().teamId;
            TeamControl.getInstance().reqInviteGame(_loc_2, _loc_3);
            return;
        }// end function

        private function searchPlayer(param1:String = "") : void
        {
            var content:* = param1;
            if (this.isCanSearch)
            {
                if (content == LanguageCfgObj.getInstance().getByIndex("11353"))
                {
                    content;
                }
                TeamControl.getInstance().reqMapSearchPlayerInfoGame(content);
                this.isCanSearch = false;
                this.delayHandler = setTimeout(function () : void
            {
                isCanSearch = true;
                clearTimeout(delayHandler);
                return;
            }// end function
            , 3);
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.searchPlayer();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            while (this.vecItemList.length > 0)
            {
                
                this.vecItemList.pop();
            }
            this.playerList.reset();
            this.selectItem = null;
            return;
        }// end function

    }
}
