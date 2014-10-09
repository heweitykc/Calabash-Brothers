package com.game.mail.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.game.backpack.model.*;
    import com.game.mail.bean.*;
    import com.game.mail.protocol.*;
    import com.game.mail.view.*;
    import com.game.map.control.*;
    import com.game.utils.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MailController extends Object
    {
        private var _curIndex:int;
        private var _curPage:int;
        private var _reqIndex:int;
        private var _type:int = 2;
        private var _totalNum:int;
        private var _isInfoGet:Boolean;
        private var _mail:MailPanel;
        private var _protocol:MailProtocol;
        private var _readedList:Vector.<MailSummaryInfo>;
        private var _unReadList:Vector.<MailSummaryInfo>;
        private var _curTotalPage:int;
        private var _curReadedPage:int;
        private var _curUnreadPage:int;
        private var _totalPage:int;
        private var _unreadedPage:int;
        private var _readedPage:int;
        private var _newMail:int;
        private var _briefList:Vector.<MailSummaryInfo>;
        private var _info:MailInfoView;
        private var _list:MailListView;
        private var _servericon:MailServerIcon;
        public var _detailInfo:MailDetailInfo;
        public var preShow:Function;
        private var _isShortCut:Boolean;
        private var _kind_type:int;
        private var _priTime:int = 0;
        private var _onekeyDropPoint:Point;
        private var getItemId:int;
        public static const PAGESIZE:int = 5;
        public static const DEL_TIME:Number = 8.64e+008;
        private static var _inst:MailController;

        public function MailController()
        {
            this._readedList = new Vector.<MailSummaryInfo>;
            this._unReadList = new Vector.<MailSummaryInfo>;
            this._briefList = new Vector.<MailSummaryInfo>;
            this._protocol = new MailProtocol();
            return;
        }// end function

        public function get isShortCut() : Boolean
        {
            return this._isShortCut;
        }// end function

        public function set isShortCut(param1:Boolean) : void
        {
            this._isShortCut = param1;
            return;
        }// end function

        public function get onekeyDropPoint() : Point
        {
            return this._onekeyDropPoint;
        }// end function

        public function set onekeyDropPoint(param1:Point) : void
        {
            this._onekeyDropPoint = param1;
            return;
        }// end function

        public function get isInfoGet() : Boolean
        {
            return this._isInfoGet;
        }// end function

        public function set isInfoGet(param1:Boolean) : void
        {
            this._isInfoGet = param1;
            return;
        }// end function

        public function get kind_type() : int
        {
            return this._kind_type;
        }// end function

        public function set kind_type(param1:int) : void
        {
            this._kind_type = param1;
            return;
        }// end function

        public function get unReadList() : Vector.<MailSummaryInfo>
        {
            return this._unReadList;
        }// end function

        public function set unReadList(param1:Vector.<MailSummaryInfo>) : void
        {
            this._unReadList = param1;
            return;
        }// end function

        public function get newMail() : int
        {
            return this._newMail;
        }// end function

        public function set newMail(param1:int) : void
        {
            this._newMail = param1;
            MapControl.getInstance().showCount(param1);
            return;
        }// end function

        public function get readedList() : Vector.<MailSummaryInfo>
        {
            return this._readedList;
        }// end function

        public function set readedList(param1:Vector.<MailSummaryInfo>) : void
        {
            this._readedList = param1;
            return;
        }// end function

        public function get curIndex() : int
        {
            return this._curIndex;
        }// end function

        public function set curIndex(param1:int) : void
        {
            this._curIndex = param1;
            return;
        }// end function

        public function get briefList() : Vector.<MailSummaryInfo>
        {
            return this._briefList;
        }// end function

        public function set briefList(param1:Vector.<MailSummaryInfo>) : void
        {
            this._briefList = param1;
            return;
        }// end function

        public function get totalPage() : int
        {
            return this._totalPage;
        }// end function

        public function set totalPage(param1:int) : void
        {
            this._totalPage = param1;
            return;
        }// end function

        public function get unreadedPage() : int
        {
            return this._unreadedPage;
        }// end function

        public function set unreadedPage(param1:int) : void
        {
            this._unreadedPage = param1;
            return;
        }// end function

        public function get readedPage() : int
        {
            return this._readedPage;
        }// end function

        public function set readedPage(param1:int) : void
        {
            this._readedPage = param1;
            return;
        }// end function

        public function closePanel() : void
        {
            if (this._mail && this._mail.isOpen)
            {
                this._mail.close();
            }
            this._isShortCut = false;
            return;
        }// end function

        public function get curUnreadPage() : int
        {
            return this._curUnreadPage;
        }// end function

        public function set curUnreadPage(param1:int) : void
        {
            this._curUnreadPage = param1;
            return;
        }// end function

        public function get curReadedPage() : int
        {
            return this._curReadedPage;
        }// end function

        public function set curReadedPage(param1:int) : void
        {
            this._curReadedPage = param1;
            return;
        }// end function

        public function get curTotalPage() : int
        {
            return this._curTotalPage;
        }// end function

        public function set curTotalPage(param1:int) : void
        {
            this._curTotalPage = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            this.changeToList();
            if (this._list)
            {
                this._list.info = this.getListByType(param1);
            }
            return;
        }// end function

        public function getListByType(param1:int) : Vector.<MailSummaryInfo>
        {
            var _loc_2:* = new Vector.<MailSummaryInfo>;
            if (param1 == 2)
            {
                _loc_2 = this._briefList.slice((this._curTotalPage - 1) * PAGESIZE, this._curTotalPage * PAGESIZE);
                while (_loc_2.length == 0 && this._curTotalPage > 1)
                {
                    
                    var _loc_3:* = this;
                    var _loc_4:* = this._curTotalPage - 1;
                    _loc_3._curTotalPage = _loc_4;
                    _loc_2 = this._briefList.slice((this._curTotalPage - 1) * PAGESIZE, this._curTotalPage * PAGESIZE);
                }
            }
            if (param1 == 1)
            {
                _loc_2 = this._readedList.slice((this._curReadedPage - 1) * PAGESIZE, this._curReadedPage * PAGESIZE);
                while (_loc_2.length == 0 && this._curReadedPage > 1)
                {
                    
                    var _loc_3:* = this;
                    var _loc_4:* = this._curReadedPage - 1;
                    _loc_3._curReadedPage = _loc_4;
                    _loc_2 = this._readedList.slice((this._curReadedPage - 1) * PAGESIZE, this._curReadedPage * PAGESIZE);
                }
            }
            if (param1 == 0)
            {
                _loc_2 = this._unReadList.slice((this._curUnreadPage - 1) * PAGESIZE, this._curUnreadPage * PAGESIZE);
                while (_loc_2.length == 0 && this._curUnreadPage > 1)
                {
                    
                    var _loc_3:* = this;
                    var _loc_4:* = this._curUnreadPage - 1;
                    _loc_3._curUnreadPage = _loc_4;
                    _loc_2 = this._unReadList.slice((this._curUnreadPage - 1) * PAGESIZE, this._curUnreadPage * PAGESIZE);
                }
            }
            return _loc_2;
        }// end function

        public function removeServerIcon() : void
        {
            if (this._servericon)
            {
                Global.popManager.removeServerToCue(this._servericon);
            }
            return;
        }// end function

        private function showMailDeltail() : void
        {
            if (this._list)
            {
                if (this._list.visible)
                {
                    this.changeToInfo();
                }
                this.transUnReadToReaded(this._detailInfo);
                this._info.info = this._detailInfo;
                this._detailInfo = null;
                this.preShow = null;
            }
            return;
        }// end function

        public function getInfoRes(param1:MailDetailInfo) : void
        {
            if (this._reqIndex > -1)
            {
                this._curIndex = this._reqIndex;
                this._reqIndex = -1;
            }
            if (this._list)
            {
                if (this._list.visible)
                {
                    this.changeToInfo();
                }
                this.transUnReadToReaded(param1);
                this._info.info = param1;
            }
            else
            {
                this._detailInfo = param1;
                this.preShow = this.showMailDeltail;
            }
            return;
        }// end function

        public function transUnReadToReaded(param1:MailDetailInfo) : void
        {
            var _loc_2:* = this.getUnreadIndexById(param1.mailid);
            if (_loc_2 == -1)
            {
                return;
            }
            var _loc_4:* = this;
            var _loc_5:* = this.newMail - 1;
            _loc_4.newMail = _loc_5;
            var _loc_3:* = this._unReadList.splice(_loc_2, 1)[0];
            _loc_3.btRead = 1;
            _loc_2 = this.getIndexByTime(_loc_3);
            this._readedList.splice(_loc_2, 0, _loc_3);
            this.checkMailCount();
            this._readedPage = int((this._readedList.length - 1) / PAGESIZE) + 1;
            this._unreadedPage = int((this._unReadList.length - 1) / PAGESIZE) + 1;
            return;
        }// end function

        public function getTotalInfo(param1:long) : MailSummaryInfo
        {
            var _loc_2:* = this._briefList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._briefList[_loc_3].mailid.equal(param1))
                {
                    return this._briefList[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function getIndexByTime(param1:MailSummaryInfo) : int
        {
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this._readedList.length - 1;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = _loc_3 + _loc_2 >> 1;
                if (param1.nSendTime > this._readedList[_loc_4].nSendTime)
                {
                    _loc_3 = _loc_4;
                }
                else
                {
                    _loc_2 = _loc_4;
                }
                if (_loc_4 == _loc_2)
                {
                    if (param1.nSendTime >= this._readedList[_loc_4].nSendTime)
                    {
                        return _loc_2;
                    }
                    return (_loc_2 + 1);
                }
            }
            return _loc_4;
        }// end function

        public function getUnreadIndexById(param1:long) : int
        {
            var _loc_2:* = this._unReadList.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._unReadList[_loc_3].mailid.equal(param1))
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function get list() : MailListView
        {
            return this._list;
        }// end function

        public function set list(param1:MailListView) : void
        {
            this._list = param1;
            return;
        }// end function

        public function get info() : MailInfoView
        {
            return this._info;
        }// end function

        public function set info(param1:MailInfoView) : void
        {
            this._info = param1;
            return;
        }// end function

        public function returnBack() : void
        {
            this._list.info = this.getListByType(this._type);
            return;
        }// end function

        public function checkMailCount() : void
        {
            var _loc_4:* = null;
            if (this._briefList == null)
            {
                return;
            }
            var _loc_1:* = this._briefList.length;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1)
            {
                
                if (this._briefList[_loc_3].btRead == 0 && this.isConformToNew(this._briefList[_loc_3]))
                {
                    _loc_2++;
                }
                _loc_3++;
            }
            if (_loc_2 > 0)
            {
                this._servericon = new MailServerIcon("mailservericon");
                this._servericon.count = _loc_2;
                Global.popManager.addedServerToCueCount(this._servericon, _loc_2);
            }
            else
            {
                _loc_4 = Global.popManager.getServerToCue("mailservericon") as MailServerIcon;
                if (_loc_4)
                {
                    Global.popManager.removeServerToCue(_loc_4);
                }
            }
            return;
        }// end function

        public function reqListRes(param1:Vector.<MailSummaryInfo>) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = param1.length;
            this._briefList.splice(0, this._briefList.length);
            this._unReadList.splice(0, this._unReadList.length);
            this._readedList.splice(0, this._readedList.length);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                if (param1[_loc_5].btRead)
                {
                    this._readedList.push(param1[_loc_5]);
                }
                else
                {
                    if (this.isConformToNew(param1[_loc_5]))
                    {
                        _loc_4++;
                    }
                    this._unReadList.push(param1[_loc_5]);
                    _loc_3++;
                }
                _loc_5++;
            }
            this._readedList.sort(this.timeSort);
            this._unReadList.sort(this.timeSort);
            this._briefList = this._unReadList.concat(this._readedList);
            if (_loc_4 > 0)
            {
                this._servericon = new MailServerIcon("mailservericon");
                this._servericon.count = _loc_4;
                Global.popManager.addedServerToCueCount(this._servericon, _loc_4);
            }
            else
            {
                _loc_6 = Global.popManager.getServerToCue("mailservericon") as MailServerIcon;
                if (_loc_6)
                {
                    Global.popManager.removeServerToCue(_loc_6);
                }
            }
            this.newMail = _loc_3;
            this._totalPage = int((this._briefList.length - 1) / PAGESIZE) + 1;
            this._readedPage = int((this._readedList.length - 1) / PAGESIZE) + 1;
            this._unreadedPage = int((this._unReadList.length - 1) / PAGESIZE) + 1;
            this._curTotalPage = 1;
            this._curReadedPage = 1;
            this._curUnreadPage = 1;
            if (this.kind_type == 1)
            {
                this.changeToList();
                if (this._mail)
                {
                    this._mail.doTotalClick();
                }
                this.type = 2;
            }
            return;
        }// end function

        public function isConformToNew(param1:MailSummaryInfo) : Boolean
        {
            if (param1.btAccessory || param1.szTitle.indexOf("GM") != -1)
            {
                return true;
            }
            return false;
        }// end function

        private function timeSort(param1:MailSummaryInfo, param2:MailSummaryInfo) : int
        {
            if (param1.nSendTime < param2.nSendTime)
            {
                return -1;
            }
            if (param1.nSendTime > param2.nSendTime)
            {
                return 1;
            }
            return 0;
        }// end function

        public function getNextItem() : void
        {
            var _loc_1:* = BackpackObj.getInstance().getIdle();
            var _loc_2:* = this.getNextMail();
            if (_loc_2)
            {
                if (_loc_2.summaryitemlist.length <= _loc_1)
                {
                    _loc_2.btRead = 1;
                    this._protocol.getItem(_loc_2.mailid, long.fromNumber(-1));
                }
                else
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10900"));
                    return;
                }
                (MailController.getInstance().newMail - 1);
                this._servericon = Global.popManager.getServerToCue("mailservericon") as MailServerIcon;
                if (this._servericon)
                {
                    _loc_1 = this._servericon.count;
                }
                else
                {
                    _loc_1 = 1;
                }
                _loc_1 = _loc_1 - 1;
                if (_loc_1 > 0)
                {
                    Global.popManager.addedServerToCueCount(this._servericon, _loc_1);
                }
                else
                {
                    Global.popManager.removeServerToCue(this._servericon);
                }
            }
            return;
        }// end function

        private function compare(param1:MailSummaryInfo, param2:MailSummaryInfo) : int
        {
            if (param1.nSendTime > param2.nSendTime)
            {
                return -1;
            }
            if (param1.nSendTime < param2.nSendTime)
            {
                return 1;
            }
            return 0;
        }// end function

        public function openMailUnread() : void
        {
            if (this._mail && this._mail.isOpen && this.kind_type == 2)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10901"));
                return;
            }
            var _loc_1:* = this.getNextMailId();
            this._isShortCut = true;
            if (_loc_1)
            {
                this.openMailUn(2, _loc_1);
            }
            return;
        }// end function

        private function getNextMail() : MailSummaryInfo
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._briefList && this._briefList.length > 0)
            {
                _loc_1 = this._briefList.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    if (this._briefList[_loc_2].btRead == 0 && this.isConformToNew(this._briefList[_loc_2]))
                    {
                        return this._briefList[_loc_2];
                    }
                    _loc_2++;
                }
            }
            return null;
        }// end function

        public function openMailUn(param1:int = 1, param2:long = null) : void
        {
            if (this._mail == null)
            {
                this._mail = new MailPanel();
                Global.popManager.addPop(this._mail);
            }
            this.kind_type = param1;
            if (param2)
            {
                this._protocol.getInfo(param2);
            }
            this.reqList(1);
            if (!this._mail.isOpen)
            {
                this._mail.open();
            }
            return;
        }// end function

        private function getNextMailId() : long
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._briefList && this._briefList.length > 0)
            {
                _loc_1 = this._briefList.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    if (this._briefList[_loc_2].btRead == 0 && this.isConformToNew(this._briefList[_loc_2]))
                    {
                        return this._briefList[_loc_2].mailid;
                    }
                    _loc_2++;
                }
            }
            return null;
        }// end function

        public function openMail(param1:int = 1, param2:long = null) : void
        {
            if (this._mail == null)
            {
                this._mail = new MailPanel();
                Global.popManager.addPop(this._mail);
            }
            this.kind_type = param1;
            if (param2)
            {
                this._protocol.getInfo(param2);
            }
            this.reqList(1);
            this._mail.openOrClose();
            return;
        }// end function

        public function getInfo(param1:long, param2:int = -1) : void
        {
            this._reqIndex = param2;
            this._protocol.getInfo(param1);
            return;
        }// end function

        public function reqList(param1:int, param2:int = 2) : void
        {
            this._protocol.getList();
            return;
        }// end function

        public function getList() : void
        {
            this._list.info = this.getListByType(this._type);
            return;
        }// end function

        public function getItem(param1:long, param2:long) : void
        {
            this._protocol.getItem(param1, param2);
            return;
        }// end function

        public function getItemRes(param1:MailDetailInfo, param2:Vector.<int>) : void
        {
            var _loc_3:* = null;
            if (this._mail && this._mail.isOpen && this._mail.UILoaded && this.isInfoGet)
            {
                this._info.getItemRes(param2);
                _loc_3 = this.getTotalInfo(param1.mailid);
                _loc_3.btAccessory = 0;
                this._info.info = param1;
                this.isInfoGet = false;
            }
            else
            {
                MailDropControl.getInstance().addItems(param2);
                clearTimeout(this.getItemId);
                this.getItemId = setTimeout(this.getNextItem, 100);
            }
            return;
        }// end function

        public function delMail(param1:int, param2:Vector.<long>) : void
        {
            if (param2.length != 0)
            {
                this._protocol.delMail(param1, param2);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10902"));
            }
            return;
        }// end function

        public function getInfoByIndex(param1:int) : void
        {
            if (this._type == 2)
            {
                this.getInfo(this._briefList[param1].mailid, param1);
            }
            else if (this._type == 1)
            {
                this.getInfo(this._readedList[param1].mailid, param1);
            }
            else if (this._type == 0)
            {
                this.getInfo(this._unReadList[param1].mailid, param1);
            }
            return;
        }// end function

        public function getPageIndex(param1:int) : int
        {
            var _loc_2:* = this.getPage(this._type);
            this._reqIndex = (_loc_2 - 1) * PAGESIZE + param1;
            return this._reqIndex;
        }// end function

        public function getPage(param1:int) : int
        {
            if (param1 == 2)
            {
                return this._curTotalPage;
            }
            if (param1 == 1)
            {
                return this._curReadedPage;
            }
            if (param1 == 0)
            {
                return this._curUnreadPage;
            }
            return 1;
        }// end function

        public function getPageCount(param1:int) : int
        {
            if (param1 == 2)
            {
                return this._totalPage;
            }
            if (param1 == 1)
            {
                return this._readedPage;
            }
            if (param1 == 0)
            {
                return this._unreadedPage;
            }
            return 1;
        }// end function

        public function changeToInfo() : void
        {
            if (this._info && this._list)
            {
                this.kind_type = 2;
                this._info.visible = true;
                this._list.visible = false;
            }
            return;
        }// end function

        public function changeToList() : void
        {
            if (this._info && this._list)
            {
                this.kind_type = 1;
                this._info.visible = false;
                this._list.visible = true;
            }
            return;
        }// end function

        public function get totalNum() : int
        {
            if (this._type == 2)
            {
                return this._briefList.length;
            }
            if (this._type == 1)
            {
                return this._readedList.length;
            }
            if (this._type == 0)
            {
                return this._unReadList.length;
            }
            return 0;
        }// end function

        public function pageChange(param1:int) : void
        {
            if (this._mail)
            {
                this._mail.setPageCount(param1);
            }
            if (MailController.getInstance().type == 2)
            {
                MailController.getInstance().curTotalPage = param1;
            }
            else if (MailController.getInstance().type == 1)
            {
                MailController.getInstance().curReadedPage = param1;
            }
            else
            {
                MailController.getInstance().curUnreadPage = param1;
            }
            return;
        }// end function

        public static function getInstance() : MailController
        {
            var _loc_1:* = new MailController;
            _inst = new MailController;
            return _inst || _loc_1;
        }// end function

    }
}
