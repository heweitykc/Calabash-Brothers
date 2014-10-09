package com.game.map.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.scrollSP.*;
    import com.game.role.*;
    import com.game.team.message.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class BigMapCurrentView extends Component
    {
        private var _mapView:BigMapBackgroundSP;
        private var _inputX:TextField;
        private var _inputY:TextField;
        private var _goBtn:BaseButton;
        private var _flyBtn:BaseButton;
        private var _leftBtn:BaseButton;
        private var _rightBtn:BaseButton;
        private var _transforList:List;
        private var _mapRecList:List;
        private var _dropIconList:Vector.<IconItem>;
        private var mapBorder:MovieClip;
        private var _userInfo:PlayerInfo;
        private var _worldMapInfo:WorldMapInfo;
        private var _curDropPos:int;
        private var _curDropList:Array;
        private const MAX_DROP_ICON:uint = 6;
        private const DROP_ICON_OFFSET:uint = 8;
        private const DROP_ICON_BACK:String = "commonRewardBox40Img";
        private var isInit:Boolean;

        public function BigMapCurrentView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._inputX = getDisplayChildByName("inputX") as TextField;
            this._inputY = getDisplayChildByName("inputY") as TextField;
            var _loc_6:* = "0-9";
            this._inputY.restrict = "0-9";
            this._inputX.restrict = _loc_6;
            var _loc_6:* = 4;
            this._inputY.maxChars = 4;
            this._inputX.maxChars = _loc_6;
            this._transforList = new List(205, 304);
            this._transforList.cellRenderer = BigMapTransforItem;
            this._transforList.move(470, 41);
            addChild(this._transforList);
            this._mapRecList = new List(205, 96);
            this._mapRecList.cellRenderer = BigMapRecItem;
            this._mapRecList.move(470, 383);
            addChild(this._mapRecList);
            this._userInfo = UserObj.getInstance().playerInfo;
            var _loc_1:* = getDisplayChildByName("btn_go") as MovieClip;
            this._goBtn = new BaseButton(_loc_1["btn_go"]);
            this._flyBtn = new BaseButton(getDisplayChildByName("btn_fly"));
            this._flyBtn.visible = false;
            this._mapView = new BigMapBackgroundSP();
            this._mapView.move(12, 36);
            addChild(this._mapView);
            this._leftBtn = new BaseButton(getDisplayChildByName("leftBtn"));
            this._rightBtn = new BaseButton(getDisplayChildByName("rightBtn"));
            this.addListener();
            this._dropIconList = new Vector.<IconItem>;
            var _loc_3:* = 0;
            var _loc_4:* = this._leftBtn.x + this._leftBtn.width + this.DROP_ICON_OFFSET;
            var _loc_5:* = (this._rightBtn.x - _loc_4 - this.DROP_ICON_OFFSET) / this.MAX_DROP_ICON;
            while (_loc_3 < this.MAX_DROP_ICON)
            {
                
                _loc_2 = new IconItem(this.DROP_ICON_BACK);
                _loc_2.x = _loc_4 + _loc_5 * _loc_3;
                _loc_2.y = this._leftBtn.y + (this._leftBtn.height - _loc_2.height >> 1);
                _loc_2.image.move(8, 8);
                addChild(_loc_2);
                this._dropIconList.push(_loc_2);
                _loc_3 = _loc_3 + 1;
            }
            this._updateMapTransforList(0);
            this.isInit = true;
            this.reset();
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_FIGHT_NUMBER, this.fightPowerUpdate);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.fightPowerUpdate);
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.isInit)
            {
                this.updateMapRecList(this._userInfo.fightPower);
                _loc_1 = RoleList.getInstance().player as Player;
                if (_loc_1)
                {
                    this.updateUserByPos(_loc_1._x, _loc_1._y, false);
                }
                if (_loc_1.isPathing && _loc_1.target && _loc_1.path)
                {
                    _loc_2 = [_loc_1.target.concat()].concat(_loc_1.path.concat());
                    this.userFindPath(_loc_2);
                }
                this.isInit = false;
            }
            this._mapView.reset();
            return;
        }// end function

        private function addListener() : void
        {
            this._leftBtn.addEventListener(MouseEvent.CLICK, this._click);
            this._rightBtn.addEventListener(MouseEvent.CLICK, this._click);
            this._goBtn.addEventListener(MouseEvent.CLICK, this._click);
            this._flyBtn.addEventListener(MouseEvent.CLICK, this._click);
            return;
        }// end function

        private function _click(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            switch(event.currentTarget)
            {
                case this._leftBtn:
                {
                    this._changeBeginPosByChangeVal(-1);
                    break;
                }
                case this._rightBtn:
                {
                    this._changeBeginPosByChangeVal(1);
                    break;
                }
                case this._goBtn:
                {
                    if (this._inputX.text == "" || this._inputY.text == "")
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10935"));
                        return;
                    }
                    _loc_2 = MapUtils.tile2Coo([parseInt(this._inputX.text), parseInt(this._inputY.text)]);
                    this.userGoToPos(_loc_2[0], _loc_2[1]);
                    break;
                }
                case this._flyBtn:
                {
                    if (this._inputX.text == "" || this._inputY.text == "")
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10935"));
                        return;
                    }
                    _loc_3 = parseInt(this._inputX.text);
                    _loc_4 = parseInt(this._inputY.text);
                    MapControl.getInstance().changeMapByPos(MapObj.getInstance().mapID, _loc_3, _loc_4, new long(0, 0), 0);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function userGoToPos(param1:int, param2:int, param3:int = 0) : void
        {
            var _loc_4:* = null;
            _loc_4 = RoleList.getInstance().player;
            _loc_4.pathByCoo(param1, param2, 0, param3, true);
            return;
        }// end function

        public function updateMapView(param1:uint) : void
        {
            this._worldMapInfo = MapCfgObj.getInstance().getWorldMap(param1);
            if (this._worldMapInfo)
            {
                this._mapView.updateMapView(param1, this._worldMapInfo.mapWidth, this._worldMapInfo.mapHeight);
                this._updateMapDropIcon(param1);
            }
            else
            {
                Log.error("地图ID" + param1 + "没有数据");
            }
            return;
        }// end function

        private function _updateMapTransforList(param1:uint) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getAllWorldTransforMapList();
            this._transforList.objs = _loc_2;
            var _loc_3:* = 0;
            var _loc_4:* = _loc_2.length;
            while (_loc_3 < _loc_4)
            {
                
                BigMapTransforItem(this._transforList.getContent(_loc_3)).index = _loc_3;
                _loc_3++;
            }
            return;
        }// end function

        private function _updateMapDropIcon(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (!this._curDropList)
            {
                this._curDropList = [];
            }
            this._curDropList.splice(0, this._curDropList.length);
            var _loc_2:* = this._worldMapInfo.mapDrop;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_7 = ItemCfgObj.getInstance().getCfgBy(_loc_2[_loc_4].itemModelId);
                if (PropUtil.isEquip(_loc_7.q_type))
                {
                    _loc_6 = new EquipmentInfo();
                    _loc_6.conByWorldMapDropInfo(_loc_2[_loc_4]);
                    this._curDropList.push(_loc_6);
                }
                else
                {
                    _loc_5 = new PropInfo();
                    _loc_5.conByWorldMapDropInfo(_loc_2[_loc_4]);
                    this._curDropList.push(_loc_5);
                }
                _loc_4++;
            }
            this._updateMapDropIconByBeginPos(0);
            return;
        }// end function

        private function _updateMapDropIconByBeginPos(param1:uint) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._worldMapInfo)
            {
                this._curDropPos = param1;
                _loc_2 = this._curDropList.length > this.MAX_DROP_ICON ? (this.MAX_DROP_ICON) : (this._curDropList.length);
                _loc_3 = param1;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    this._dropIconList[_loc_4].needTips = true;
                    this._dropIconList[_loc_4].setInfo(this._curDropList[_loc_3]);
                    _loc_3++;
                    _loc_4++;
                }
                while (_loc_4 < this.MAX_DROP_ICON)
                {
                    
                    this._dropIconList[_loc_4].needTips = false;
                    _loc_4++;
                }
            }
            return;
        }// end function

        private function _changeBeginPosByChangeVal(param1:int) : void
        {
            var _loc_2:* = this._curDropPos + param1;
            if (_loc_2 < 0 || _loc_2 > this._curDropList.length - this.MAX_DROP_ICON)
            {
                return;
            }
            this._updateMapDropIconByBeginPos(_loc_2);
            return;
        }// end function

        private function fightPowerUpdate(event:RoleEvent) : void
        {
            this.updateMapRecList(UserObj.getInstance().playerInfo.fightPower);
            return;
        }// end function

        public function updateMapRecList(param1:int) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getAllRecommandMonListByFormula();
            this._mapRecList.reset();
            this._mapRecList.objs = _loc_2;
            var _loc_3:* = 0;
            var _loc_4:* = _loc_2.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_4)
            {
                
                BigMapRecItem(this._mapRecList.getContent(_loc_3)).index = _loc_3;
                _loc_3++;
            }
            return;
        }// end function

        public function updateUserDir(param1:int) : void
        {
            this._mapView.updateUserPyDir(param1);
            return;
        }// end function

        public function updateUserByPos(param1:int, param2:int, param3:Boolean) : void
        {
            this._mapView.updateUserByPos(param1, param2, param3);
            return;
        }// end function

        public function userFindPath(param1:Array) : void
        {
            this._mapView.userFindPath(param1);
            return;
        }// end function

        public function teamMemberUpdate(param1:ResTeamClientRefreshMessage) : void
        {
            if (this._mapView)
            {
                this._mapView.teamMemberUpdate(param1);
            }
            return;
        }// end function

        public function teamMemberPosUpdate(param1:ResTeammateMoveToClientMessage) : void
        {
            if (this._mapView)
            {
                this._mapView.teamMemberPosUpdate(param1);
            }
            return;
        }// end function

    }
}
