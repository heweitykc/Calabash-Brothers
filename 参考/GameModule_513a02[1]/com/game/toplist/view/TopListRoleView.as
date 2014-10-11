package com.game.toplist.view
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.vmc.*;
    import com.game.artifact.cfg.*;
    import com.game.artifact.view.*;
    import com.game.player.control.*;
    import com.game.player.view.*;
    import com.game.primaryrole.view.*;
    import com.game.role.*;
    import com.game.toplist.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;

    public class TopListRoleView extends Component
    {
        private var _weaItem1:RoleEquipBox;
        private var _weaItem2:RoleEquipBox;
        private var _weaItem3:RoleEquipBox;
        private var _weaItem4:RoleEquipBox;
        private var _weaItem5:RoleEquipBox;
        private var _weaItem6:RoleEquipBox;
        private var _weaItem7:RoleEquipBox;
        private var _weaItem8:RoleEquipBox;
        private var _weaItem9:RoleEquipBox;
        private var _weaItem10:RoleEquipBox;
        private var _weaItem11:RoleEquipBox;
        private var _weaItem12:RoleEquipBox;
        private const TOTAL_NUM:int = 12;
        private var _viewType:int;
        private var _info:TopListInfo;
        private var _playerView:RoleView;
        private var _horseView:VMCView;
        private var _horseWingPhoto:VMCView;
        private var _magicBookPhoto:VMCView;
        private var _horseName:Image;
        private var _playerInfo:PlayerInfo;
        private var _checkBtn:BaseButton;
        private var _role:MovieClip;
        private var _horse:MovieClip;
        private var horseInfo:HorseInfo;
        private var _weapoenView:ArtifactPhotoView;
        private var _weapoenNameView:Image;
        private var maskPanel:MovieClip;
        private var _magicBookStarsMC:MovieClip;
        private var _magicBookStars:Vector.<MovieClip>;
        public static const ITEM_TYPE:int = 0;
        public static const ARTIFACT_TYPE:int = 1;
        public static const HORSE_TYPE:int = 2;
        public static const MAGIC_BOOK_TYPE:int = 3;
        private static const TOTLE_STARS:int = 10;

        public function TopListRoleView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        public function get viewType() : int
        {
            return this._viewType;
        }// end function

        public function set viewType(param1:int) : void
        {
            this._viewType = param1;
            if (this._viewType == ITEM_TYPE)
            {
                this._setEquipItemVisible(true);
                this._removeHorse();
                this._removeWeapoen();
                this._removeMagicBook();
            }
            else if (this._viewType == HORSE_TYPE)
            {
                this._setEquipItemVisible(false);
                this._horse.gotoAndStop(1);
                this._removeRole();
                this._removeHorse();
                this._removeMagicBook();
            }
            else if (this._viewType == MAGIC_BOOK_TYPE)
            {
                this._horse.gotoAndStop(3);
                this._removeRole();
                this._removeHorse();
                this._removeWeapoen();
            }
            else
            {
                this._setEquipItemVisible(false);
                this._horse.gotoAndStop(2);
                this._removeRole();
                this._removeWeapoen();
                this._removeMagicBook();
            }
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this.maskPanel = getDisplayChildByName("maskPanel");
            this.maskPanel.visible = false;
            this._role = getDisplayChildByName("role");
            this._horse = getDisplayChildByName("horse");
            var _loc_1:* = 1;
            while (_loc_1 <= this.TOTAL_NUM)
            {
                
                this["_weaItem" + _loc_1] = new RoleEquipBox(this._role["wea_" + _loc_1], null, false);
                _loc_1++;
            }
            this._checkBtn = new BaseButton(this._role["btn_check"]);
            this._checkBtn.addEventListener(MouseEvent.CLICK, this.__click);
            this._checkBtn.setText(LanguageCfgObj.getInstance().getByIndex("11371"));
            this._magicBookStars = new Vector.<MovieClip>(TOTLE_STARS);
            this._magicBookStarsMC = getDisplayChildByName("magicBookStar");
            var _loc_2:* = 1;
            while (_loc_2 <= TOTLE_STARS)
            {
                
                _loc_3 = MovieClip(this._magicBookStarsMC.getChildByName("star" + _loc_2));
                _loc_3.gotoAndStop(1);
                this._magicBookStars[(_loc_2 - 1)] = _loc_3;
                _loc_2++;
            }
            return;
        }// end function

        public function setInfo(param1:TopListInfo, param2:int = 0) : void
        {
            this.viewType = param2;
            this._info = param1;
            if (this._info == null)
            {
                this._resetView();
            }
            else
            {
                this._updateView();
            }
            if (param1 && param1.playerid.high == 0 && param1.playerid.low == 0)
            {
                this.maskPanel.visible = true;
            }
            else
            {
                this.maskPanel.visible = false;
            }
            return;
        }// end function

        public function get info() : TopListInfo
        {
            return this._info;
        }// end function

        private function _setWeaList(param1:Vector.<EquipInfo>) : void
        {
            var _loc_4:* = null;
            if (!TopListControl.getInstance().weaList)
            {
                TopListControl.getInstance().weaList = new Vector.<EquipmentInfo>;
            }
            TopListControl.getInstance().weaList.splice(0, TopListControl.getInstance().weaList.length);
            var _loc_2:* = 1;
            var _loc_3:* = param1.length;
            while (_loc_2 <= this.TOTAL_NUM)
            {
                
                this["_weaItem" + _loc_2].pos = _loc_2;
                if (param1[(_loc_2 - 1)].itemModelId == 0)
                {
                    TopListControl.getInstance().weaList.push(null);
                    this["_weaItem" + _loc_2].info = null;
                }
                else
                {
                    _loc_4 = new EquipmentInfo();
                    _loc_4.con(param1[(_loc_2 - 1)], (_loc_2 - 1));
                    _loc_4.euipSource = EquipmentInfo.EQUIP_SOURCE_TOPLIST;
                    this["_weaItem" + _loc_2].info = _loc_4;
                    TopListControl.getInstance().weaList.push(_loc_4);
                }
                _loc_2++;
            }
            this._updatePlayer();
            return;
        }// end function

        private function _updateView() : void
        {
            if (this._viewType == ITEM_TYPE)
            {
                this._setWeaList(this._info.itemlist);
            }
            else if (this._viewType == ARTIFACT_TYPE)
            {
                this.updateWeapoen();
            }
            else if (this._viewType == MAGIC_BOOK_TYPE)
            {
                this.updateMagicBook();
            }
            else
            {
                this._updateHorse();
            }
            addChild(this._checkBtn);
            return;
        }// end function

        private function updateMagicBook() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < TOTLE_STARS)
            {
                
                if (_loc_1 < this._info.magicBookStar)
                {
                    this._magicBookStars[_loc_1].gotoAndStop(1);
                }
                else
                {
                    this._magicBookStars[_loc_1].gotoAndStop(2);
                }
                _loc_1++;
            }
            this._magicBookStarsMC.visible = true;
            var _loc_2:* = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._info.magicBookLevel);
            if (!this._magicBookPhoto)
            {
                this._magicBookPhoto = new VMCView();
                this._magicBookPhoto.move(190, 250);
            }
            if (_loc_2)
            {
                this._magicBookPhoto.auto = true;
                this._magicBookPhoto.direct = -135;
                this._magicBookPhoto.repeat = true;
                this._magicBookPhoto.loadRes(_loc_2.panelModelUrl);
                this.addChild(this._magicBookPhoto);
            }
            this._setEquipItemVisible(false);
            return;
        }// end function

        private function _updateHorse() : void
        {
            if (!this._info)
            {
                return;
            }
            this._setEquipItemVisible(false);
            this._removeWeapoen();
            if (!this._horseView)
            {
                this._horseView = new VMCView();
                this._horseView.move(190, 230);
            }
            this.horseInfo = HorseCfgObj.getInstance().getInfoFromLevel(this.info.horselevel);
            this._horseView.auto = true;
            this._horseView.direct = -135;
            this._horseView.repeat = true;
            this._horseView.loadRes(Params.HORSE_PATH + this.horseInfo.horse_id + "/act01/135.png");
            if (!this._horseView.parent)
            {
                this.addChild(this._horseView);
            }
            if (this.horseInfo.q_horse_wing == 1)
            {
                if (!this._horseWingPhoto)
                {
                    this._horseWingPhoto = new VMCView();
                    this._horseWingPhoto.move(this._horseView._x, this._horseView._y);
                    this.addChild(this._horseWingPhoto);
                }
                this._horseWingPhoto.direct = -135;
                this._horseWingPhoto.loadRes(Params.HORSE_PATH + this.horseInfo.horse_id + "01/act01.png");
                this._horseView.appendView(this._horseWingPhoto);
            }
            else if (this._horseWingPhoto)
            {
                this._horseView.removeAppend(this._horseWingPhoto);
                if (this._horseWingPhoto.parent)
                {
                    this._horseWingPhoto.parent.removeChild(this._horseWingPhoto);
                }
                if (this._horseWingPhoto.playing)
                {
                    this._horseWingPhoto.stop();
                }
                this._horseWingPhoto.finalize();
                this._horseWingPhoto = null;
            }
            if (!this._horseName)
            {
                this._horseName = new Image();
                this._horseName.move(105, 15);
            }
            this._horseName.load(Params.ZONES_LEVEL_PATH + this.horseInfo.horse_id + ".png");
            if (!this._horseName.parent)
            {
                this.addChild(this._horseName);
            }
            return;
        }// end function

        private function _updatePlayer() : void
        {
            if (!TopListControl.getInstance().weaList)
            {
                return;
            }
            this._setEquipItemVisible(true);
            if (!this._playerInfo)
            {
                this._playerInfo = new PlayerInfo();
            }
            this._playerInfo.setByTopListInfo(this._info);
            return;
        }// end function

        private function updateWeapoen() : void
        {
            if (!this._info)
            {
                return;
            }
            this._setEquipItemVisible(false);
            this._removeHorse();
            if (!this._weapoenView)
            {
                this._weapoenView = new ArtifactPhotoView();
                this._weapoenView.move(25, -54);
            }
            var _loc_1:* = ArtifactPropertyCfgObj.getInstance().getCfg(this.info.alv);
            if (!_loc_1)
            {
                return;
            }
            this._weapoenView.setArtifact(_loc_1);
            if (!this._weapoenView.parent)
            {
                this.addChild(this._weapoenView);
            }
            if (!this._weapoenNameView)
            {
                this._weapoenNameView = new Image();
                this._weapoenNameView.move(105, 6);
            }
            this._weapoenNameView.load(_loc_1.nameUrl);
            if (!this._weapoenNameView.parent)
            {
                this.addChild(this._weapoenNameView);
            }
            return;
        }// end function

        private function _resetView() : void
        {
            this._removeRole();
            this._removeHorse();
            this._removeWeapoen();
            this._removeMagicBook();
            var _loc_1:* = 1;
            while (_loc_1 <= this.TOTAL_NUM)
            {
                
                this["_weaItem" + _loc_1].info = null;
                _loc_1++;
            }
            if (this._viewType == ITEM_TYPE)
            {
                this._setEquipItemVisible(true);
            }
            else
            {
                this._setEquipItemVisible(false);
            }
            return;
        }// end function

        private function _setEquipItemVisible(param1:Boolean) : void
        {
            this._role.visible = param1;
            this._horse.visible = !param1;
            return;
        }// end function

        private function _removeHorse() : void
        {
            if (this._horseView && this.contains(this._horseView))
            {
                this.removeChild(this._horseView);
                this._horseView.auto = false;
            }
            if (this._horseName && this._horseName.parent)
            {
                this._horseName.parent.removeChild(this._horseName);
            }
            if (this._horseWingPhoto)
            {
                this._horseView.removeAppend(this._horseWingPhoto);
                if (this._horseWingPhoto.playing)
                {
                    this._horseWingPhoto.stop();
                }
                if (this._horseWingPhoto.parent)
                {
                    this._horseWingPhoto.parent.removeChild(this._horseWingPhoto);
                }
                this._horseWingPhoto.finalize();
                this._horseWingPhoto = null;
            }
            return;
        }// end function

        private function _removeRole() : void
        {
            if (this._playerView && this.contains(this._playerView))
            {
                this.removeChild(this._playerView);
                this._playerView.auto = false;
            }
            return;
        }// end function

        private function _removeWeapoen() : void
        {
            if (this._weapoenNameView && this.contains(this._weapoenNameView))
            {
                this.removeChild(this._weapoenNameView);
            }
            if (this._weapoenView && this.contains(this._weapoenView))
            {
                this.removeChild(this._weapoenView);
            }
            return;
        }// end function

        private function _removeMagicBook() : void
        {
            this._magicBookStarsMC.visible = false;
            if (this._magicBookPhoto && this.contains(this._magicBookPhoto))
            {
                this.removeChild(this._magicBookPhoto);
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            if (this._info)
            {
                switch(this.viewType)
                {
                    case ITEM_TYPE:
                    {
                        PlayerControl.getInstance().reqForPlayer(this._info.playerid, OtherRoleMainPanel.ROLE);
                        break;
                    }
                    case ARTIFACT_TYPE:
                    {
                        PlayerControl.getInstance().reqForPlayer(this._info.playerid, OtherRoleMainPanel.ARTIFACT);
                        break;
                    }
                    case HORSE_TYPE:
                    {
                        PlayerControl.getInstance().reqForPlayer(this._info.playerid, OtherRoleMainPanel.HORSE);
                        break;
                    }
                    case MAGIC_BOOK_TYPE:
                    {
                        PlayerControl.getInstance().reqForPlayer(this._info.playerid, OtherRoleMainPanel.MAGICBOOK);
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

        public function setAuto(param1:Boolean) : void
        {
            if (this._horseView)
            {
                this._horseView.auto = param1;
            }
            if (this._playerView)
            {
                this._playerView.auto = param1;
            }
            return;
        }// end function

    }
}
