using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Security
    {
        public Security() { }

        public static String Encriptar(String texto, String key)
        {
            String textEnctype = null;
            try
            {
                byte[] keyArray;
                byte[] Arreglo_a_Cifrar = UTF8Encoding.UTF8.GetBytes(texto);
                

                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                hashmd5.Clear();

                TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

                tdes.Key = keyArray;
                tdes.Mode = CipherMode.ECB;
                tdes.Padding = PaddingMode.PKCS7;

                ICryptoTransform cTransform = tdes.CreateEncryptor();
                byte[] ArrayResultado = cTransform.TransformFinalBlock(Arreglo_a_Cifrar, 0, Arreglo_a_Cifrar.Length);

                tdes.Clear();
                textEnctype = Convert.ToBase64String(ArrayResultado, 0, ArrayResultado.Length);

            }
            catch (Exception)
            {
                return null;
            }

            return textEnctype;
        }

        public static String Desencriptar(String textoEncriptado, String key)
        {
            String texto = null;

            try
            {
                byte[] keyArray;
                byte[] Array_a_Descifrar = Convert.FromBase64String(textoEncriptado);

                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                hashmd5.Clear();

                TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

                tdes.Key = keyArray;
                tdes.Mode = CipherMode.ECB;
                tdes.Padding = PaddingMode.PKCS7;

                ICryptoTransform cTransform = tdes.CreateDecryptor();
                byte[] resultArray = cTransform.TransformFinalBlock(Array_a_Descifrar, 0, Array_a_Descifrar.Length);

                tdes.Clear();
                texto = UTF8Encoding.UTF8.GetString(resultArray);

            }
            catch (Exception)
            {
                return null;
            }

            return texto;
        }

        public static String GenerateRandomKey(int len = 80)
        {
            String hash = null;

            try
            {
                Random obj = new Random();
                String posibles = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890&%$#!=?¡¿@.-_*";
                int longitud = posibles.Length;
                char letra;
                string nuevacadena = "";
                for (int i = 0; i < len; i++)
                {
                    letra = posibles[obj.Next(longitud)];
                    nuevacadena += letra.ToString();
                }
                String General = nuevacadena;
                hash = General;

            }catch(Exception ex)
            {
                String error = ex.Message;
            }

            return hash;
        }
    }
}
