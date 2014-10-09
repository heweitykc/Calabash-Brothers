package com.game.map.view.scrollSP
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.autopk.controller.*;
    import com.game.fight.control.*;
    import com.game.map.view.viewItem.*;
    import com.game.role.*;
    import com.game.team.bean.*;
    import com.game.team.message.*;
    import com.game.team.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import interfaces.role.*;

    public class BigMapBackgroundSP extends BaseSprite
    {
        private var _scrollBack:ScrollSPBase;
        private var _back:ImageSP;
        private var _upBtn:BaseButton;
        private var _downBtn:BaseButton;
        private var _leftBtn:BaseButton;
        private var _rightBtn:BaseButton;
        private var _mapArrowBtn:Vector.<BaseButton>;
        private var _npcList:Vector.<BigMapSimpleItem>;
        private var _transforList:Vector.<BigMapSimpleItem>;
        private var _monsterList:Vector.<BigMapSimpleItem>;
        private var _teamList:Vector.<BigMapSimpleItem>;
        private var _bossList:Vector.<BigMapSimpleItem>;
        private var _creamList:Vector.<BigMapSimpleItem>;
        private var _userView:Sprite;
        private var _pathPoint:Shape;
        private var _mapTransfor:BaseButton;
        private var _curPointTip:Object;
        private var _mapNameBorder:MovieClip;
        private var _mapNameImg:Image;
        private var _border:MovieClip;
        private var _countryIcon:Vector.<DisplayObject>;
        private var _leadPoint:Point;
        private var _mapWidth:Number;
        private var _mapHeight:Number;
        private var _scale:Number;
        private var _curMapId:int;
        private var _user:IRole;
        private var path:Array;
        private var pointArr:Array;
        private var pointIndexArr:Array;
        private var mouseTips:String;
        private var lastTipTime:Number;
        private var bigWidth:Number = 0;
        private var bigHeight:Number = 0;
        private const PER_STEP:uint = 20;
        private const VIEW_WIDTH:uint = 441;
        private const VIEW_HEIGHT:uint = 306;
        private const ARROW_NUM:uint = 4;
        private const ARROW_OFFSET_Y:uint = 5;
        private const PATH_POINT_DIS:uint = 4;
        private const USER_ICON:String = "world_map_user";
        private var isInit:Boolean = true;

        public function BigMapBackgroundSP()
        {
            var _loc_2:* = null;
            this._teamList = new Vector.<BigMapSimpleItem>;
            this._back = new ImageSP();
            this._scrollBack = new ScrollSPBase(this.VIEW_WIDTH, this.VIEW_HEIGHT);
            this._scrollBack.seContent(this._back, Layout.CENTER, false);
            this._scrollBack.setMouseUpFun(this._bgMouseUp);
            addChild(this._scrollBack);
            this._border = ToolKit.getNew("vippanel7") as MovieClip;
            this._border.width = this.VIEW_WIDTH;
            this._border.height = this.VIEW_HEIGHT;
            var _loc_3:* = false;
            this._border.mouseChildren = false;
            this._border.mouseEnabled = _loc_3;
            addChild(this._border);
            this._mapNameImg = new Image();
            this._mapNameBorder = ToolKit.getNew("bigmap_name_bg") as MovieClip;
            this._mapNameBorder.addChild(this._mapNameImg);
            addChild(this._mapNameBorder);
            Layout.layoutMC(this, this._mapNameBorder, Layout.BOTTOM_CENTER, 0, 5);
            this._mapArrowBtn = new Vector.<BaseButton>;
            var _loc_1:* = 0;
            while (_loc_1 < this.ARROW_NUM)
            {
                
                _loc_2 = new BaseButton("big_map_arrow");
                this._mapArrowBtn.push(_loc_2);
                _loc_2.addEventListener(MouseEvent.CLICK, this._clickArrow);
                _loc_2.name = _loc_1.toString();
                _loc_2.visible = false;
                addChild(_loc_2);
                StringTip.create(_loc_2, LanguageCfgObj.getInstance().getByIndex("10955"));
                switch(_loc_1)
                {
                    case 0:
                    {
                        _loc_2.x = this.VIEW_WIDTH - _loc_2.width >> 1;
                        _loc_2.y = 10 + this.ARROW_OFFSET_Y;
                        break;
                    }
                    case 1:
                    {
                        _loc_2.rotation = 180;
                        _loc_2.x = (this.VIEW_WIDTH - _loc_2.height >> 1) + _loc_2.height;
                        _loc_2.y = this.VIEW_HEIGHT - _loc_2.height - 20 + this.ARROW_OFFSET_Y;
                        break;
                    }
                    case 2:
                    {
                        _loc_2.rotation = 270;
                        _loc_2.x = 10;
                        _loc_2.y = (this.VIEW_HEIGHT - _loc_2.height >> 1) + _loc_2.height + this.ARROW_OFFSET_Y;
                        break;
                    }
                    case 3:
                    {
                        _loc_2.rotation = 90;
                        _loc_2.x = this.VIEW_WIDTH - _loc_2.width + 30;
                        _loc_2.y = (this.VIEW_HEIGHT - _loc_2.width >> 1) + this.ARROW_OFFSET_Y;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            this._userView = ToolKit.getNew(this.USER_ICON) as Sprite;
            this._user = RoleList.getInstance().player;
            this._pathPoint = new Shape();
            this._back.addChild(this._pathPoint);
            this._mapTransfor = new BaseButton("generaTransfor_btn");
            this._mapTransfor.visible = false;
            this.mouseTips = "x:0 y:0";
            this.pointArr = [];
            this.pointIndexArr = [];
            this.path = [];
            this.addListener();
            return;
        }// end function

        private function addListener() : void
        {
            this._user.addEvtListener(RoleEvent.PATHING_UPDATE, this._userPathUpdate);
            this._back.addEventListener(MouseEvent.ROLL_OVER, this._createPointTip);
            this._user.addEvtListener(RoleEvent.PATHING_POINT_UPDATE, this._pathPointUpdate);
            addEventListener(MouseEvent.MOUSE_OVER, this._mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this._mouseOut);
            return;
        }// end function

        private function _mouseOver(event:MouseEvent) : void
        {
            if (this._mapNameBorder && contains(this._mapNameBorder))
            {
                removeChild(this._mapNameBorder);
            }
            return;
        }// end function

        private function _mouseOut(event:MouseEvent) : void
        {
            addChild(this._mapNameBorder);
            return;
        }// end function

        private function _createPointTip(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._mapNameBorder && contains(this._mapNameBorder))
            {
                removeChild(this._mapNameBorder);
            }
            if (!this._curPointTip)
            {
                this._curPointTip = StringTip.newTipSp("mouseTips");
                this._curPointTip.x = event.currentTarget.mouseX + this._scrollBack.offsetX + 27;
                this._curPointTip.y = event.currentTarget.mouseY + this._scrollBack.offsetY + 27;
                addChild(this._curPointTip);
                _loc_2 = MapUtils.coo2Tile((event.currentTarget.mouseX + this._scrollBack.offsetX) / this._scale);
                _loc_3 = MapUtils.coo2Tile((event.currentTarget.mouseY + this._scrollBack.offsetY) / this._scale);
                this._updatePointTip(_loc_2, _loc_3);
                this._back.addEventListener(MouseEvent.ROLL_OUT, this._delPointTip);
                this._back.addEventListener(MouseEvent.MOUSE_MOVE, this._onMapMove);
            }
            return;
        }// end function

        private function _onMapMove(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (event.target as ImageSP == this._back)
            {
                _loc_2 = MapUtils.coo2Tile(event.currentTarget.mouseX / this._scale);
                _loc_3 = MapUtils.coo2Tile(event.currentTarget.mouseY / this._scale);
                this._updatePointTip(_loc_2, _loc_3);
            }
            else
            {
                _loc_4 = this._npcList.indexOf(event.target as BigMapSimpleItem);
                _loc_5 = this._transforList.indexOf(event.target as BigMapSimpleItem);
                _loc_6 = this._teamList.indexOf(event.target as BigMapSimpleItem);
                _loc_7 = this._bossList.indexOf(event.target as BigMapSimpleItem);
                if (_loc_4 != -1)
                {
                    _loc_8 = this._npcList[_loc_4].info;
                    _loc_9 = NpcCfgObj.getInstance().getNpcByID(_loc_8.itemId.toString());
                    this.mouseTips = _loc_9._npcName + "\n" + "x:" + _loc_9._x + " y:" + _loc_9._y;
                    this._curPointTip.resetStr(this.mouseTips);
                }
                else if (_loc_5 != -1)
                {
                    _loc_8 = this._transforList[_loc_5].info;
                    _loc_10 = MapCfgObj.getInstance().getTransferByTransferId(_loc_8.itemId);
                    _loc_11 = MapCfgObj.getInstance().getMap(_loc_10.q_tran_to_map);
                    this.mouseTips = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12105"), [_loc_11.mapName]) + "\n" + "x:" + MapUtils.coo2Tile(_loc_10.x) + " y:" + MapUtils.coo2Tile(_loc_10.y);
                    this._curPointTip.resetStr(this.mouseTips);
                }
                else if (_loc_7 != -1)
                {
                    _loc_8 = this._bossList[_loc_7].info;
                    this.mouseTips = _loc_8.des + "\n" + "x:" + MapUtils.coo2Tile(_loc_8.posX) + " y:" + MapUtils.coo2Tile(_loc_8.posY);
                    this._curPointTip.resetStr(this.mouseTips);
                }
                else if (_loc_6 != -1)
                {
                    _loc_8 = this._teamList[_loc_6].info;
                    this.mouseTips = _loc_8.des;
                    this._curPointTip.resetStr(this.mouseTips);
                }
            }
            this._curPointTip.x = event.currentTarget.mouseX + 27 + this._scrollBack.offsetX;
            this._curPointTip.y = event.currentTarget.mouseY + 27 + this._scrollBack.offsetY;
            return;
        }// end function

        private function _updatePointTip(param1:int, param2:int) : void
        {
            if (this._curPointTip)
            {
                this.mouseTips = "x:" + param1 + " y:" + param2;
                this._curPointTip.resetStr(this.mouseTips);
            }
            return;
        }// end function

        private function _delPointTip(event:MouseEvent = null) : void
        {
            if (this._curPointTip)
            {
                if (contains(this._curPointTip))
                {
                    removeChild(this._curPointTip);
                }
                this._curPointTip = null;
                this._back.removeEventListener(MouseEvent.ROLL_OUT, this._delPointTip);
                this._back.removeEventListener(MouseEvent.MOUSE_MOVE, this._onMapMove);
            }
            return;
        }// end function

        private function _bgMouseUp(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            if (event.currentTarget != this._scrollBack)
            {
                return;
            }
            var _loc_2:* = event.currentTarget.mouseX - this._scrollBack.offsetX;
            var _loc_3:* = event.currentTarget.mouseY - this._scrollBack.offsetY;
            _loc_4 = RoleList.getInstance().player;
            AutoFightController.getInstance().closeAutoFight();
            FightControl.getInstance().delCurrentSkill();
            _loc_4.pathByCoo(_loc_2 / this._scale, _loc_3 / this._scale, 0, 0, true);
            return;
        }// end function

        public function updateMapView(param1:uint, param2:int, param3:int) : void
        {
            this._curMapId = param1;
            this.bigWidth = param2;
            this.bigHeight = param3;
            var _loc_4:* = Params.MAP_MAPRES_PATH + "worldmap/" + MapCfgObj.getInstance().getMap(param1).url + "/all.jpg";
            this._scale = NaN;
            this._back.load(_loc_4, this._loadMapComplete);
            this._mapNameImg.load(Params.ART_PATH + "worldmapname/" + param1 + ".png", this._loadMapNameComplete);
            return;
        }// end function

        private function _loadMapComplete(param1 = null) : void
        {
            var _loc_3:* = null;
            this._mapWidth = this._back.width;
            this._mapHeight = this._back.height;
            this._adjustArrow();
            this._scale = this._mapWidth / this.bigWidth;
            this._updateByMap();
            this._setBgCentre();
            var _loc_2:* = RoleList.getInstance().player as Player;
            if (_loc_2.isPathing && this.isInit && _loc_2.target && _loc_2.path)
            {
                _loc_3 = [_loc_2.target.concat()].concat(_loc_2.path.concat());
                this.userFindPath(_loc_3);
                this.isInit = false;
            }
            return;
        }// end function

        private function _loadMapNameComplete(param1:BitmapData) : void
        {
            this._mapNameImg.x = this._mapNameBorder.width - param1.width >> 1;
            this._mapNameImg.y = (this._mapNameBorder.height - param1.height >> 1) + 11;
            return;
        }// end function

        private function _updateByMap() : void
        {
            this._updateNpcByMap(this._curMapId);
            this._updateTransforByMap(this._curMapId);
            this._updateRectMonsterByMap(this._curMapId);
            this._updateTeam(this._curMapId);
            this._updateBoss(this._curMapId);
            this._updateCream(this._curMapId);
            if (!RoleList.getInstance().player.isPathing)
            {
                this.updateUserByPos(this._user._x, this._user._y, true);
            }
            this.updateUserPyDir(RoleList.getInstance().player.direct);
            return;
        }// end function

        public function updateUserByPos(param1:Number, param2:Number, param3:Boolean = false) : void
        {
            if (!isNaN(this._scale))
            {
                if (!this._back.contains(this._userView))
                {
                    this._back.addChild(this._userView);
                }
                this._userView.x = param1 * this._scale;
                this._userView.y = param2 * this._scale;
                this._setBgCentre();
            }
            if (param3)
            {
                this.path.splice(0, this.path.length);
                this.pointArr.splice(0, this.pointArr.length);
                this._delAllPathPoint();
                this._removeTransforBtn();
                if (this._scrollBack)
                {
                    this._scrollBack.hasMoveOut = false;
                }
            }
            else if (this.pointArr && this.pointArr.length)
            {
                this._updatePath();
            }
            return;
        }// end function

        private function _userPathUpdate(event:RoleEvent) : void
        {
            this.updateUserByPos(this._user._x, this._user._y);
            return;
        }// end function

        public function updateUserPyDir(param1:int) : void
        {
            this._userView.rotation = param1;
            return;
        }// end function

        public function userFindPath(param1:Array) : void
        {
            this.path = param1;
            this._drawPath(param1);
            return;
        }// end function

        private function _addTransforBtn(param1:int, param2:int) : void
        {
            if (!this._back.contains(this._mapTransfor))
            {
                this._adddItemToMap(this._mapTransfor);
            }
            this._mapTransfor.x = param1 * this._scale - (this._mapTransfor.width >> 1);
            this._mapTransfor.y = param2 * this._scale - (this._mapTransfor.height >> 1);
            return;
        }// end function

        private function _removeTransforBtn() : void
        {
            if (this._back.contains(this._mapTransfor))
            {
                this._back.removeChild(this._mapTransfor);
            }
            return;
        }// end function

        private function _drawPath(param1:Array) : void
        {
            this._delAllPathPoint();
            this.pointArr.splice(0, this.pointArr.length);
            this.pointIndexArr.splice(0, this.pointIndexArr.length);
            this.pointIndexArr.push(0);
            var _loc_2:* = 0;
            var _loc_3:* = param1.length;
            while (_loc_2 < _loc_3)
            {
                
                if (_loc_2 == 0)
                {
                    this._drawPathByBeginEnd(this._user._x * this._scale, this._user._y * this._scale, param1[_loc_2][0] * this._scale, param1[_loc_2][1] * this._scale);
                }
                else
                {
                    this._drawPathByBeginEnd(param1[(_loc_2 - 1)][0] * this._scale, param1[(_loc_2 - 1)][1] * this._scale, param1[_loc_2][0] * this._scale, param1[_loc_2][1] * this._scale);
                }
                _loc_2++;
            }
            this._addTransforBtn(param1[(_loc_3 - 1)][0], param1[(_loc_3 - 1)][1]);
            return;
        }// end function

        private function _drawPathByBeginEnd(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = false;
            var _loc_16:* = false;
            var _loc_5:* = Math.abs(param1 - param3);
            var _loc_6:* = Math.abs(param2 - param4);
            var _loc_7:* = _loc_5 > _loc_6 ? (Math.ceil(_loc_5 / this.PATH_POINT_DIS)) : (Math.ceil(_loc_6 / this.PATH_POINT_DIS));
            _loc_5 = _loc_5 / _loc_7;
            _loc_6 = _loc_6 / _loc_7;
            var _loc_8:* = 0;
            var _loc_11:* = param1 < param3 ? (1) : (-1);
            var _loc_12:* = param2 < param4 ? (1) : (-1);
            while (_loc_8 <= _loc_7)
            {
                
                _loc_13 = _loc_8 * _loc_5;
                _loc_14 = _loc_8 * _loc_6;
                _loc_16 = false;
                if (Math.abs(param3 - param1) >= _loc_13)
                {
                    _loc_9 = param1 + _loc_13 * _loc_11;
                }
                else
                {
                    _loc_9 = param3;
                }
                if (Math.abs(param4 - param2) >= _loc_14)
                {
                    _loc_10 = param2 + _loc_14 * _loc_12;
                }
                else
                {
                    _loc_10 = param4;
                }
                if (_loc_9 == param3 && _loc_10 == param4)
                {
                    var _loc_17:* = true;
                    _loc_15 = true;
                    _loc_16 = _loc_17;
                }
                this._drawPathPoint(_loc_9, _loc_10);
                if (_loc_16)
                {
                    this.pointIndexArr.push((this.pointArr.length - 1));
                }
                _loc_8++;
            }
            if (!_loc_15)
            {
                this._drawPathPoint(param3, param4);
                this.pointIndexArr.push((this.pointArr.length - 1));
            }
            return;
        }// end function

        private function _drawPathPoint(param1:Number, param2:Number) : void
        {
            this._pathPoint.graphics.beginFill(16773120, 1);
            this._pathPoint.graphics.drawCircle(param1, param2, 1);
            this._pathPoint.graphics.endFill();
            this.pointArr.push([param1, param2]);
            return;
        }// end function

        private function _delAllPathPoint() : void
        {
            if (this._pathPoint)
            {
                this._pathPoint.graphics.clear();
            }
            return;
        }// end function

        private function _updatePath() : void
        {
            var _loc_4:* = false;
            var _loc_1:* = 0;
            var _loc_2:* = this.pointArr.concat();
            var _loc_3:* = _loc_2.length;
            var _loc_5:* = this._user._x * this._scale;
            var _loc_6:* = this._user._y * this._scale;
            _loc_1 = 0;
            while (_loc_1 < (_loc_3 - 1))
            {
                
                if (_loc_1 > this.pointIndexArr[0])
                {
                    return;
                }
                if (this.isBetweenTwoNum(_loc_5, this.pointArr[0][0], this.pointArr[(_loc_1 + 1)][0]) || this.isBetweenTwoNum(_loc_6, this.pointArr[0][1], this.pointArr[(_loc_1 + 1)][1]))
                {
                    _loc_4 = true;
                    break;
                }
                _loc_1 = _loc_1 + 1;
            }
            if (_loc_4)
            {
                this._delAllPathPoint();
                _loc_2.splice(0, (_loc_1 + 1));
                this.pointArr.splice(0, _loc_3);
                _loc_3 = _loc_2.length;
                _loc_1 = 0;
                while (_loc_1 < _loc_3)
                {
                    
                    this._drawPathPoint(_loc_2[_loc_1][0], _loc_2[_loc_1][1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            return;
        }// end function

        private function _adddItemToMap(param1:DisplayObject) : void
        {
            if (this._back)
            {
                this._back.addChild(param1);
                this._updateUserToTopLayer();
            }
            return;
        }// end function

        private function _addItemListToMap(param1:Vector.<BigMapSimpleItem>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._back && param1)
            {
                _loc_2 = 0;
                _loc_3 = param1.length;
                while (_loc_2 < _loc_3)
                {
                    
                    this._back.addChild(param1[_loc_2]);
                    _loc_2++;
                }
                this._updateUserToTopLayer();
            }
            return;
        }// end function

        private function _updateNpcByMap(param1:uint) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (!this._npcList)
            {
                this._npcList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllNpc();
            this.removeAllCountryIcon();
            if (param1 == Params.COUNTRY_MAP_ID)
            {
                this._updateCountryByMap(param1);
                return;
            }
            var _loc_2:* = NpcCfgObj.getInstance();
            var _loc_3:* = _loc_2.getNpcIDListByMapID(param1.toString());
            var _loc_4:* = 0;
            var _loc_5:* = _loc_3.length;
            while (_loc_4 < _loc_5)
            {
                
                _loc_8 = new BigMapItemInfo();
                _loc_8.conByNpcObj(_loc_2.getNpcByID(_loc_3[_loc_4]));
                _loc_7 = new BigMapSimpleItem();
                _loc_7.info = _loc_8;
                _loc_7.x = _loc_8.posX * this._scale;
                _loc_7.y = _loc_8.posY * this._scale;
                this._npcList.push(_loc_7);
                _loc_4++;
            }
            this._addItemListToMap(this._npcList);
            return;
        }// end function

        private function _updateCountryByMap(param1:uint) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 != Params.COUNTRY_MAP_ID)
            {
                return;
            }
            if (!this._countryIcon)
            {
                this._countryIcon = new Vector.<DisplayObject>;
            }
            var _loc_2:* = [186, 221, 309, 161, 415, 109, 524, 56];
            var _loc_3:* = ["res/image/countryIcon/door.png", "res/image/countryIcon/door.png", "res/image/countryIcon/door.png", "res/image/countryIcon/huangguan.png"];
            var _loc_4:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new Image();
                _loc_7.x = _loc_2[_loc_5] * 25 * this._scale;
                _loc_7.y = _loc_2[(_loc_5 + 1)] * 25 * this._scale;
                _loc_7.load(_loc_3[_loc_5 / 2]);
                this._countryIcon.push(_loc_7);
                this._adddItemToMap(_loc_7);
                _loc_5 = _loc_5 + 2;
            }
            var _loc_6:* = ["外墙城门", "中墙城门", "内墙城门", "王座", "外墙机关", "中墙机关", "内墙机关"];
            _loc_2 = [181, 235, 304, 175, 410, 124, 524, 64, 170, 242, 270, 188, 365, 140];
            _loc_4 = _loc_2.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = new TextField();
                _loc_8.selectable = false;
                _loc_8.textColor = 16777113;
                _loc_8.filters = [FrameworkGlobal.BLACK_FILTER];
                _loc_8.width = 100;
                _loc_8.height = 20;
                _loc_8.text = _loc_6[_loc_5 / 2];
                _loc_8.x = _loc_2[_loc_5] * 25 * this._scale;
                _loc_8.y = _loc_2[(_loc_5 + 1)] * 25 * this._scale;
                this._countryIcon.push(_loc_8);
                this._adddItemToMap(_loc_8);
                _loc_5 = _loc_5 + 2;
            }
            return;
        }// end function

        private function removeAllCountryIcon() : void
        {
            var _loc_1:* = 0;
            if (this._countryIcon)
            {
                _loc_1 = 0;
                while (_loc_1 < this._countryIcon.length)
                {
                    
                    if (this._countryIcon[_loc_1].parent)
                    {
                        this._countryIcon[_loc_1].parent.removeChild(this._countryIcon[_loc_1]);
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function _updateTransforByMap(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            if (!this._transforList)
            {
                this._transforList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllTransfor();
            var _loc_5:* = MapCfgObj.getInstance().getTransferByMapId(param1);
            for each (_loc_6 in _loc_5)
            {
                
                _loc_2 = new BigMapItemInfo();
                _loc_2.conByTransferInfo(_loc_6);
                _loc_3 = new BigMapSimpleItem();
                _loc_3.info = _loc_2;
                _loc_3.x = _loc_2.posX * this._scale;
                _loc_3.y = _loc_2.posY * this._scale;
                this._transforList.push(_loc_3);
            }
            this._addItemListToMap(this._transforList);
            return;
        }// end function

        private function _updateRectMonsterByMap(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!this._monsterList)
            {
                this._monsterList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllMonster();
            var _loc_5:* = MapCfgObj.getInstance().getAllRecommandMonListByMapWithoutLv(param1);
            if (!MapCfgObj.getInstance().getAllRecommandMonListByMapWithoutLv(param1))
            {
                return;
            }
            for each (_loc_6 in _loc_5)
            {
                
                _loc_2 = new BigMapItemInfo();
                _loc_2.conByMonInfo(_loc_6);
                _loc_3 = new BigMapSimpleItem();
                var _loc_11:* = false;
                _loc_3.mouseEnabled = false;
                _loc_3.mouseChildren = _loc_11;
                _loc_3.info = _loc_2;
                _loc_3.x = _loc_2.posX * this._scale;
                _loc_3.y = _loc_2.posY * this._scale;
                this._monsterList.push(_loc_3);
            }
            this._addItemListToMap(this._monsterList);
            return;
        }// end function

        private function _updateBoss(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            if (!this._bossList)
            {
                this._bossList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllBoss();
            if (UserObj.getInstance().line != 1)
            {
                return;
            }
            var _loc_5:* = MapCfgObj.getInstance().getAllRecommandBossListByMapWithoutLv(param1);
            if (!MapCfgObj.getInstance().getAllRecommandBossListByMapWithoutLv(param1))
            {
                return;
            }
            for each (_loc_6 in _loc_5)
            {
                
                _loc_2 = new BigMapItemInfo();
                _loc_2.conByBossInfo(_loc_6);
                _loc_3 = new BigMapSimpleItem();
                _loc_3.info = _loc_2;
                _loc_3.x = _loc_2.posX * this._scale;
                _loc_3.y = _loc_2.posY * this._scale;
                this._bossList.push(_loc_3);
            }
            this._addItemListToMap(this._bossList);
            return;
        }// end function

        private function _updateCream(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            if (!this._creamList)
            {
                this._creamList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllCream();
            if (UserObj.getInstance().line != 1)
            {
                return;
            }
            var _loc_5:* = MapCfgObj.getInstance().getAllRecommandCreamListByMapWithoutLv(param1);
            if (!MapCfgObj.getInstance().getAllRecommandCreamListByMapWithoutLv(param1))
            {
                return;
            }
            for each (_loc_6 in _loc_5)
            {
                
                _loc_2 = new BigMapItemInfo();
                _loc_2.conByCreamInfo(_loc_6);
                _loc_3 = new BigMapSimpleItem();
                _loc_3.info = _loc_2;
                _loc_3.x = _loc_2.posX * this._scale;
                _loc_3.y = _loc_2.posY * this._scale;
                this._bossList.push(_loc_3);
            }
            this._addItemListToMap(this._bossList);
            return;
        }// end function

        private function _updateTeam(param1:uint) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this._teamList)
            {
                this._teamList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllTeam();
            var _loc_2:* = TeamModel.getInstance().vecTeamInfo;
            if (_loc_2 && _loc_2.length)
            {
                for each (_loc_6 in _loc_2)
                {
                    
                    if (_loc_6.memberid.equal(UserObj.getInstance().playerInfo.personId))
                    {
                        continue;
                    }
                    if (_loc_6.membermapid != param1)
                    {
                        continue;
                    }
                    _loc_3 = new BigMapItemInfo();
                    _loc_3.conByTeamInfo(_loc_6);
                    _loc_4 = new BigMapSimpleItem();
                    _loc_4.info = _loc_3;
                    _loc_4.x = _loc_3.posX * this._scale;
                    _loc_4.y = _loc_3.posY * this._scale;
                    this._teamList.push(_loc_4);
                }
                this._addItemListToMap(this._teamList);
            }
            return;
        }// end function

        public function teamMemberUpdate(param1:ResTeamClientRefreshMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this._teamList)
            {
                this._teamList = new Vector.<BigMapSimpleItem>;
            }
            this._removeAllTeam();
            for each (_loc_5 in param1.memberinfo)
            {
                
                if (_loc_5.memberid.equal(UserObj.getInstance().playerInfo.personId))
                {
                    continue;
                }
                _loc_2 = new BigMapItemInfo();
                _loc_2.conByTeamInfo(_loc_5);
                _loc_3 = new BigMapSimpleItem();
                _loc_3.info = _loc_2;
                _loc_3.x = _loc_2.posX * this._scale;
                _loc_3.y = _loc_2.posY * this._scale;
                this._teamList.push(_loc_3);
            }
            this._addItemListToMap(this._teamList);
            return;
        }// end function

        public function teamMemberPosUpdate(param1:ResTeammateMoveToClientMessage) : void
        {
            var _loc_2:* = null;
            if (this._teamList && this._teamList.length)
            {
                for each (_loc_2 in this._teamList)
                {
                    
                    if (_loc_2.info.serverId.equal(param1.memberid))
                    {
                        _loc_2.info.posX = param1.mx;
                        _loc_2.info.posY = param1.my;
                        _loc_2.x = _loc_2.info.posX * this._scale;
                        _loc_2.y = _loc_2.info.posY * this._scale;
                    }
                }
            }
            return;
        }// end function

        private function _updateUserToTopLayer() : void
        {
            if (this._userView && this._back.contains(this._userView))
            {
                this._back.addChild(this._userView);
            }
            return;
        }// end function

        private function _removeAllNpc() : void
        {
            this._removeAllItem(this._npcList);
            return;
        }// end function

        private function _removeAllTransfor() : void
        {
            this._removeAllItem(this._transforList);
            return;
        }// end function

        private function _removeAllBoss() : void
        {
            this._removeAllItem(this._bossList);
            return;
        }// end function

        private function _removeAllCream() : void
        {
            this._removeAllItem(this._creamList);
            return;
        }// end function

        private function _removeAllMonster() : void
        {
            this._removeAllItem(this._monsterList);
            return;
        }// end function

        private function _removeAllTeam() : void
        {
            this._removeAllItem(this._teamList);
            return;
        }// end function

        private function _removeAllItem(param1:Vector.<BigMapSimpleItem>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param1)
            {
                _loc_2 = 0;
                _loc_3 = param1.length;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_4 = param1[_loc_2];
                    if (this._back.contains(_loc_4))
                    {
                        this._back.removeChild(_loc_4);
                    }
                    _loc_4.dispose();
                    var _loc_5:* = null;
                    param1[_loc_2] = null;
                    _loc_4 = _loc_5;
                    _loc_2++;
                }
                param1.splice(0, param1.length);
            }
            return;
        }// end function

        private function _setBgCentre() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._mapWidth > this.VIEW_WIDTH)
            {
                _loc_1 = (-this._user._x) * this._scale + (this.VIEW_WIDTH >> 1);
            }
            if (this._mapHeight > this.VIEW_HEIGHT)
            {
                _loc_2 = (-this._user._y) * this._scale + (this.VIEW_HEIGHT >> 1);
            }
            this._scrollBack.setOffset(_loc_1, _loc_2);
            return;
        }// end function

        public function moveStep(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this._scrollBack.moveContent(0, this.PER_STEP);
                    break;
                }
                case 1:
                {
                    this._scrollBack.moveContent(0, -this.PER_STEP);
                    break;
                }
                case 2:
                {
                    this._scrollBack.moveContent(this.PER_STEP, 0);
                    break;
                }
                case 3:
                {
                    this._scrollBack.moveContent(-this.PER_STEP, 0);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function _clickArrow(event:MouseEvent) : void
        {
            this.moveStep(int(event.currentTarget.name));
            return;
        }// end function

        private function _click(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            switch(event.currentTarget)
            {
                case this._mapTransfor:
                {
                    _loc_2 = this.path.length;
                    if (this.path && _loc_2)
                    {
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

        private function _adjustArrow() : void
        {
            if (this._mapHeight > this.VIEW_HEIGHT)
            {
                var _loc_1:* = true;
                this._mapArrowBtn[1].visible = true;
                this._mapArrowBtn[0].visible = _loc_1;
            }
            else
            {
                var _loc_1:* = false;
                this._mapArrowBtn[1].visible = false;
                this._mapArrowBtn[0].visible = _loc_1;
            }
            if (this._mapWidth > this.VIEW_WIDTH)
            {
                var _loc_1:* = true;
                this._mapArrowBtn[3].visible = true;
                this._mapArrowBtn[2].visible = _loc_1;
            }
            else
            {
                var _loc_1:* = false;
                this._mapArrowBtn[3].visible = false;
                this._mapArrowBtn[2].visible = _loc_1;
            }
            return;
        }// end function

        private function isBetweenTwoNum(param1:Number, param2:Number, param3:Number) : Boolean
        {
            if (param2 > param3)
            {
                return param1 >= param3 && param1 <= param2;
            }
            return param1 >= param2 && param1 <= param3;
        }// end function

        private function _pathPointUpdate(event:RoleEvent) : void
        {
            this.pointIndexArr.shift();
            return;
        }// end function

        public function reset() : void
        {
            addChild(this._mapNameBorder);
            return;
        }// end function

    }
}
