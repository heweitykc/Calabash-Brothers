package com.riaidea.text
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    class SpriteRenderer extends Object
    {
        private var _rtf:RichTextField;
        private var _numSprites:int;
        private var _spriteContainer:Sprite;
        private var _spriteIndices:Dictionary;

        function SpriteRenderer(param1:RichTextField)
        {
            this._rtf = param1;
            this._numSprites = 0;
            this._spriteContainer = new Sprite();
            this._spriteIndices = new Dictionary();
            return;
        }// end function

        function render() : void
        {
            if (this._numSprites > 0)
            {
                this._spriteContainer.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            this._spriteContainer.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.doRender();
            return;
        }// end function

        private function doRender() : void
        {
            this._spriteContainer.y = -this.textRenderer.scrollHeight;
            this.renderVisibleSprites();
            return;
        }// end function

        private function renderVisibleSprites() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = this.textRenderer.scrollV - 1;
            var _loc_2:* = this.textRenderer.bottomScrollV - 1;
            var _loc_3:* = this.textRenderer.getLineOffset(_loc_1);
            var _loc_4:* = this.textRenderer.getLineOffset(_loc_2) + this.textRenderer.getLineLength(_loc_2) - 1;
            while (this._spriteContainer.numChildren > 0)
            {
                
                this._spriteContainer.removeChildAt(0);
            }
            while (_loc_3 <= _loc_4)
            {
                
                if (this._rtf.isSpriteAt(_loc_3))
                {
                    _loc_5 = this.getSprite(_loc_3);
                    if (_loc_5 != null)
                    {
                        this.renderSprite(_loc_5, _loc_3);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private function renderSprite(param1:DisplayObject, param2:int) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_3:* = this.textRenderer.getCharBoundaries(param2);
            if (_loc_3 != null)
            {
                param1.x = _loc_3.x + (_loc_3.width - param1.width) * 0.5 + 0.5 >> 0;
                if (_loc_3.height > 30)
                {
                    if (param1.height >= 30)
                    {
                        _loc_4 = _loc_3.height - param1.height + 7;
                    }
                    else if (param1.height >= 25)
                    {
                        _loc_4 = _loc_3.height - param1.height + 4;
                    }
                    else if (param1.height <= 20)
                    {
                        _loc_4 = _loc_3.height - param1.height - 1;
                    }
                    else
                    {
                        _loc_4 = _loc_3.height - param1.height;
                    }
                }
                else if (_loc_3.height > 16)
                {
                    if (param1.height >= 30)
                    {
                        _loc_4 = _loc_3.height - param1.height + 7;
                    }
                    else if (param1.height >= 25)
                    {
                        _loc_4 = _loc_3.height - param1.height + 4;
                    }
                    else if (param1.height <= 20)
                    {
                        _loc_4 = _loc_3.height - param1.height - 1;
                    }
                    else
                    {
                        _loc_4 = _loc_3.height - param1.height;
                    }
                }
                else
                {
                    _loc_4 = _loc_3.height - param1.height;
                }
                _loc_5 = this.textRenderer.getLineMetrics(this.textRenderer.getLineIndexOfChar(param2));
                if (_loc_4 + param1.height < _loc_5.ascent)
                {
                    _loc_4 = _loc_5.ascent - param1.height;
                }
                param1.y = _loc_3.y + _loc_4 + 0.5 >> 0;
                param1.y = param1.y + (this.textRenderer.scrollHeight >> 0);
                this._spriteContainer.addChild(param1);
            }
            return;
        }// end function

        function adjustSpritesIndex(param1:int, param2:int) : Boolean
        {
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            var _loc_3:* = false;
            for (_loc_4 in this._spriteIndices)
            {
                
                _loc_5 = int(_loc_4.name);
                if (_loc_5 > param1 - param2)
                {
                    _loc_4.name = _loc_5 + param2;
                    _loc_3 = true;
                }
            }
            return _loc_3;
        }// end function

        function insertSprite(param1:DisplayObject, param2:int) : void
        {
            if (this._spriteIndices[param1] == null)
            {
                param1.name = String(param2);
                this._spriteIndices[param1] = true;
                var _loc_3:* = this;
                var _loc_4:* = this._numSprites + 1;
                _loc_3._numSprites = _loc_4;
            }
            return;
        }// end function

        function removeSprite(param1:int) : void
        {
            var _loc_2:* = this.getSprite(param1);
            if (_loc_2 != null)
            {
                if (this._spriteContainer.contains(_loc_2))
                {
                    this._spriteContainer.removeChild(_loc_2);
                }
                delete this._spriteIndices[_loc_2];
                var _loc_3:* = this;
                var _loc_4:* = this._numSprites - 1;
                _loc_3._numSprites = _loc_4;
            }
            return;
        }// end function

        function getSprite(param1:int) : DisplayObject
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this._spriteIndices)
            {
                
                if (param1 == int(_loc_2.name))
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        function getSpriteIndex(param1:DisplayObject) : int
        {
            if (this._spriteIndices[param1] == true)
            {
                return int(param1.name);
            }
            return -1;
        }// end function

        function clear() : void
        {
            var _loc_1:* = undefined;
            while (this._spriteContainer.numChildren > 0)
            {
                
                this._spriteContainer.removeChildAt(0);
            }
            for (_loc_1 in this._spriteIndices)
            {
                
                delete _loc_3[_loc_1];
            }
            this._numSprites = 0;
            return;
        }// end function

        private function get textRenderer() : TextRenderer
        {
            return this._rtf.textfield as TextRenderer;
        }// end function

        function get container() : Sprite
        {
            return this._spriteContainer;
        }// end function

        function get numSprites() : int
        {
            return this._numSprites;
        }// end function

        function exportXML() : XML
        {
            var _loc_2:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = [];
            for (_loc_2 in this._spriteIndices)
            {
                
                _loc_5 = {src:getQualifiedClassName(_loc_2), index:_loc_2.name};
                _loc_1.push(_loc_5);
            }
            if (_loc_1.length > 1)
            {
                _loc_1.sortOn("index", Array.NUMERIC);
            }
            var _loc_3:* = <sprites/>;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                _loc_6 = new XML("<sprite src=\"" + _loc_1[_loc_4].src + "\" index=\"" + (_loc_1[_loc_4].index - _loc_4) + "\"/>");
                _loc_3.appendChild(_loc_6);
                _loc_4++;
            }
            return _loc_3;
        }// end function

    }
}
