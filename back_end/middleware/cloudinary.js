const cloudinary = require('cloudinary').v2;
const dotenv=require('dotenv');
const defaultImageBuffer = 'https://console.cloudinary.com/pm/c-13fd3ce62c7fc6945052e7e86cff2d/media-explorer?assetId=138f2e7c890feea57d4e610cdc55f917';
const multer = require('multer');
const upload = multer();

dotenv.config();

cloudinary.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
})

// Define a function to handle the image upload
const handleImageUpload = async (req) => {
  return new Promise((resolve, reject) => {
    // Check if file exists in request
    if (!req.file) {
      // Resolve with an empty object
      resolve({});
    } else {
      // Upload image buffer to Cloudinary with resizing transformation
      cloudinary.uploader.upload_stream(
        { 
          resource_type: 'auto',
          transformation: [
            { width: 625, height: 800, crop: 'fill' } 
          ]
        },
        async (error, result) => {
          if (error) {
            console.error(error);
            reject('Something went wrong during image upload');
          }

          // Once uploaded, you can access the resized image URL from the result object
          const resizedImageUrl = result.secure_url;

          // You can also store this URL in a database if needed

          // Resolve with the resizedImageUrl
          resolve(resizedImageUrl);
        }
      ).end(req.file.buffer);
    }
  }); 
};

const handleImageUploadAsync = (req, res) => {
  return new Promise((resolve, reject) => {
    // Create a Promise to handle the image upload
    const uploadPromise = new Promise((uploadResolve, uploadReject) => {
      // Manually call the multer middleware for single file upload with field name 'image'
      upload.single('image')(req, res, async (err) => {
        if (err) {
          // Handle multer middleware errors
          console.error(err);
          uploadReject('File upload failed');
        }

        // Call handleImageUpload with the appropriate parameters
        try {
          const imageUrl = await handleImageUpload(req);
          uploadResolve(imageUrl);
        } catch (error) {
          uploadReject(error);
        }
      });
    });

    // Wait for the uploadPromise to resolve or reject
    uploadPromise.then(resolve).catch(reject);
  });
};



  


module.exports={handleImageUploadAsync}