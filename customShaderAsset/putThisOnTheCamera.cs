using UnityEngine;


[RequireComponent(typeof(Camera))]//this script must be attached to the camera in the scene.

public class putThisOnTheCamera : MonoBehaviour
{
    public Material cameraShaderMaterial;// create a new material and set its shader to our customCameraShader in the "custom" section. then drag the material from the project forlder to this script

    // the OnRenderImage method is called after the rendering has completed.
    private void OnRenderImage(RenderTexture sourceImage, RenderTexture finalImage)// we take in the source image which contains the cameras render image before the shader effects are applied.
    {
        Graphics.Blit(sourceImage, finalImage, cameraShaderMaterial);// we then feed this data into the material where the shader can use it.
    }




}