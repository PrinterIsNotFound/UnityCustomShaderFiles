Shader "custom/customCameraShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}//this will be auto assigned to the camera render image.

		



		_ThresholdHigh("ThresholdHigh", Range(0.0,1.0)) = 0.567
		_ThresholdMedium("ThresholdMedium", Range(0.0,1.0)) = 0.479
		_ThresholdLow("ThresholdLow", Range(0.0,1.0)) = 0.394
		_colour1("colour1", color) = (255,255,255,0)
		_colour2("colour2", color) = (0.509434,0.509434,0.509434,0)
		_colour3("colour3", color) = (0.509434,0,0,0)
		_colour4("colour4", color) = (0.03443421,0,0.1226415,0)
		


	}
		SubShader
		{
			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;
					return o;
				}

				sampler2D _MainTex;


				half _ThresholdHigh, _ThresholdMedium, _ThresholdLow;
				half4 _colour1, _colour2, _colour3, _colour4;


				fixed4 frag(v2f i) : SV_Target
				{

					half4 col = tex2D(_MainTex, i.uv);//this is the colour of the pixel before any effects are applied. It is identical to what the camera normally sees.

					half greyScaleValue = (col.r + col.g + col.b)*0.33f;// this represents the average brightness of the pixel


					//it is not performant to use if statements in a shader. But, becuase this was made for a game jam, it is good enough.

					if (greyScaleValue > _ThresholdHigh) // if the pixel is bright we asign a specif colour
					{
						col = _colour1;
					}
					else if(greyScaleValue > _ThresholdMedium)// if the pixel is less bright we asign a specif colour
					{
						col = _colour2;
					}
					else if (greyScaleValue > _ThresholdLow)// if the pixel is dark we asign a specif colour
					{
						col = _colour3;
					}
					else // if the pixel is ver dark we asign a specif colour
					{
						col = _colour4;
					}










					
						
							

					


					return col;
				}
				ENDCG
			}
		}
}
