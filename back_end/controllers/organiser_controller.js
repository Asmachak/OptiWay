
const {generateToken} = require('../middleware/jwt')
const bcrypt = require('bcryptjs');
const defaultImageBuffer = 'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg';
const {handleImageUploadAsync} = require('../middleware/cloudinary')
const { v4: uuidv4 } = require('uuid');
const Organiser = require('../models/organiser');



async function handleAddOrganiser (req,res)

 {
    try {
      const formData = req.body;
  
      // Check if client with the same email exists
      const existingOrganiser = await Organiser.findOne({
        where: {
          email: formData.email
        }
      });
  
      if (existingOrganiser) {
        
        return res.status(400).json({msg:"try another Email adress"});
      }

      const idOrganiser = uuidv4();

      // Create a new user
      const organiser = await Organiser.create({
        id : idOrganiser,
        last_name: formData.last_name,
        name: formData.name,
        email: formData.email,
        phone: formData.phone,
        address: formData.address,
        password: await bcrypt.hash(formData.password, 10), // Ensure to hash this password before saving
        photo : defaultImageBuffer,
        city : formData.city,
        country : formData.country
      });

      const myToken = generateToken(organiser.toJSON());
      return res.status(200).json({ token: myToken, id : organiser.id , email : organiser.email , name : organiser.name , last_name : organiser.last_name , phone : organiser.phone , photo : organiser.photo , password : organiser.password , address : organiser.address , city : organiser.city, country : organiser.country});
      
    } catch (error) {
      console.error("Error:", error);
      res.status(500).send("Error is occured when handle Add organiser");
    }
};

async function updateOrganiser (req, res) {
  try {
    const organiserId = req.params.organiserId;

    const existingOrganiser = await Organiser.findByPk(organiserId);

    if (!existingOrganiser) {
      return res.status(404).json({ error: 'Organiser not found' });
    }

    const updatedOrganiserData = req.body;

    console.log(updatedOrganiserData);

    console.log("exist ",existingOrganiser);

   await existingOrganiser.update({
      last_name: updatedOrganiserData.last_name || existingOrganiser.last_name,
      name: updatedOrganiserData.name || existingOrganiser.name,
      phone: updatedOrganiserData.phone || existingOrganiser.phone,
      address: updatedOrganiserData.address || existingOrganiser.address,
      email: updatedOrganiserData.email || existingOrganiser.email,
      city: updatedOrganiserData.city || existingOrganiser.city,
      country: updatedOrganiserData.country || existingOrganiser.country,
    });

    const organiser = await Organiser.findByPk(organiserId);
    const myNewToken=generateToken(organiser.toJSON());
    console.log(myNewToken)
    return res.status(200).json({ token: myNewToken, id : organiser.id , email : organiser.email , name : organiser.name , last_name : organiser.last_name , phone : organiser.phone , photo : organiser.photo , password : organiser.password , address : organiser.address, city : organiser.city, country : organiser.country,deviceId:organiser.deviceId});

  } catch (error) {
    // Handle errors
    console.error(error);
    res.status(500).json({ success: false, error: 'Something went wrong in updateorganiser' });
  }
};

async function uploadImage(req,res){
  try {
    // Wait for the uploadPromise to resolve or reject
    const imageUrl = await handleImageUploadAsync(req, res);

    // Now you have the imageUrl, you can use it as needed
    console.log('Image URL:', imageUrl);

    let myImage = defaultImageBuffer;

    if(imageUrl.length){
      myImage = imageUrl ;
    }

    const organiserId = req.params.organiserId;

    const existingOrganiser = await Organiser.findByPk(organiserId);

    if (!existingOrganiser) {
      return res.status(404).json({ error: 'organiser not found' });
    }
    await existingOrganiser.update({
     photo : myImage,
    });
    const organiser = await Organiser.findByPk(organiserId);
    const myNewToken=generateToken(organiser.toJSON());
    console.log(myNewToken)
    return res.status(200).json({ token: myNewToken, id : organiser.id , email : organiser.email , name : organiser.name , last_name : organiser.last_name , phone : organiser.phone , photo : organiser.photo , password : organiser.password , address : organiser.address, city : organiser.city, country : organiser.country});

  } catch (error) {
        // Handle errors
        console.error(error);
        res.status(500).json({ success: false, error: 'Something went wrong in upload image' });
  }
};

async function deleteOrganiser(req,res){
try {
  const organiserId = req.params.organiserId;

  const existingOrganiser = await User.findByPk(organiserId);

  if (!existingOrganiser) {
    return res.status(404).json({ error: 'User not found' });
  }

  await User.destroy({
    where: {
      id: organiserId
    }
  });

   // Prepare the email message
   const message = `
   Dear ${existingOrganiser.name},

   We regret to inform you that your account associated with the email address ${existingOrganiser.email} has been deleted due to multiple complaints regarding your activity on our platform. This action was taken in accordance with our community guidelines to ensure a safe and positive environment for all users.

   If you believe this decision was made in error, or if you have any questions about your account status, please reach out to our support team at support@example.com. We are committed to ensuring fair treatment and are open to reviewing your case.

   Thank you for your understanding.

   Best regards,
   OptiWay
 `;

 const emailModel = {
   email: existingOrganiser.email, // Use the existing user's email
   subject: "Account Deletion ",
   body: message
 };

 // Send the email
 emailService.sendEmail(emailModel, (error, result) => {
   if (error) {
     console.error("Error sending email:", error);
   } else {
     console.log("Email sent successfully:", result);
   }
 });

  res.status(200).json("user deleted");

  
} catch (error) {
  console.error("Error:", error);
  res.status(500).send("Error is occured when deleting user !!");
  
}
};

async function editPassword(req, res) {
  try {
    const organiserId = req.params.organiserId;
    const existingOrganiser = await Organiser.findByPk(organiserId);
    const formData = req.body;

    if (!existingOrganiser) {
      console.log("Organiser does not exist");
      return res.status(400).json({ msg: "Organiser does not exist" });
    }

    const isPasswordMatch = await bcrypt.compare(
      formData.password,
      existingOrganiser.password
    );

    if (!isPasswordMatch) {
      console.log("Password does not match");
      return res.status(400).json({ msg: "Verifier vos données" });
    }

    const newHashedPassword = await bcrypt.hash(formData.newPassword, 10);
    await existingOrganiser.update({ password: newHashedPassword });
    const organiser = await Organiser.findByPk(organiserId);
    const myNewToken=generateToken(organiser.toJSON());

    return res.status(200).json({
      token: myNewToken,
      id: existingOrganiser.id,
      email: existingOrganiser.email,
      name: existingOrganiser.name,
      last_name: existingOrganiser.last_name,
      phone: existingOrganiser.phone,
      photo: existingOrganiser.photo,
      password: existingOrganiser.password, 
      address: existingOrganiser.address,
      city: existingOrganiser.city,
      country: existingOrganiser.country,
    });
  } catch (error) {
    console.log("Error:", error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
};

async function forgetPassword(req, res) {
  try {
    const formData = req.body;
  
      const existingOrganiser = await Organiser.findOne({
        where: {
          email: formData.email
        }
      });


    if (!existingOrganiser) {
      console.log("Organiser does not exist");
      return res.status(400).json({ msg: "Organiser does not exist" });
    }

    const newHashedPassword = await bcrypt.hash(formData.newPassword, 10);
    await existingOrganiser.update({ password: newHashedPassword });
    const organiser = await Organiser.findByPk(existingOrganiser.id);
    const myNewToken=generateToken(organiser.toJSON());

    return res.status(200).json({
      token: myNewToken,
      id: existingOrganiser.id,
      email: existingOrganiser.email,
      name: existingOrganiser.name,
      last_name: existingOrganiser.last_name,
      phone: existingOrganiser.phone,
      photo: existingOrganiser.photo,
      password: existingOrganiser.password, 
      address: existingOrganiser.address,
      city: existingOrganiser.city,
      country: existingOrganiser.country,
    });
  } catch (error) {
    console.log("Error:", error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
}

async function getAllOrganisers(req, res) {
  try {
    const organisers = await Organiser.findAll();
    
    // Return organisers as part of an object, in case you want to add more info later
    res.status(200).send(organisers);
    
  } catch (error) {
    console.error("Error retrieving organisers:", error);
    
    // More detailed error response
    res.status(500).json({
      success: false,
      message: "An error occurred while fetching organisers",
      error: error.message, // Optionally expose error details
    });
  }
}

module.exports={handleAddOrganiser,updateOrganiser,deleteOrganiser,uploadImage,editPassword,forgetPassword,getAllOrganisers}