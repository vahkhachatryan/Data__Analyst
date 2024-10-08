PGDMP                      |            Hotel "   14.12 (Ubuntu 14.12-1.pgdg22.04+1)     16.3 (Ubuntu 16.3-1.pgdg22.04+1) k    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16747    Hotel    DATABASE     s   CREATE DATABASE "Hotel" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE "Hotel";
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    5            �            1255    17128    process_refund()    FUNCTION     G  CREATE FUNCTION public.process_refund() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Retrieve the booking date and amount from the Payments table
    DECLARE
        payment_date DATE;
        payment_amount NUMERIC;
    BEGIN
        SELECT p."Payment_Date", p."Amount"
        INTO payment_date, payment_amount
        FROM "Payments" p
        JOIN "Bookings" b ON p."Booking_ID" = b."Booking_ID"
        WHERE b."Booking_ID" = NEW."Booking_ID";

        -- Perform the refund logic here using payment_date and payment_amount

        RETURN NEW;
    END;
END;
$$;
 '   DROP FUNCTION public.process_refund();
       public          postgres    false    5            �            1259    16770    Bookings    TABLE     <  CREATE TABLE public."Bookings" (
    "Booking_ID" integer NOT NULL,
    "Customer_ID" bigint NOT NULL,
    "Room_ID" bigint NOT NULL,
    "Booking_Date" timestamp without time zone NOT NULL,
    "CheckIn_Date" date NOT NULL,
    "Check_Out_Date" date NOT NULL,
    "Booking_Method" character varying(50) NOT NULL
);
    DROP TABLE public."Bookings";
       public         heap    postgres    false    5            �            1259    16769    Bookings_Booking_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Bookings_Booking_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Bookings_Booking_ID_seq";
       public          postgres    false    214    5            �           0    0    Bookings_Booking_ID_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."Bookings_Booking_ID_seq" OWNED BY public."Bookings"."Booking_ID";
          public          postgres    false    213            �            1259    17115    Cancels    TABLE     	  CREATE TABLE public."Cancels" (
    "Cancel_ID" integer NOT NULL,
    "Booking_ID" integer NOT NULL,
    "Cancel_Date" timestamp without time zone DEFAULT now() NOT NULL,
    "Cancel_Reason" character varying(255),
    "Refund_Amount" numeric(10,2) DEFAULT 0.00
);
    DROP TABLE public."Cancels";
       public         heap    postgres    false    5            �            1259    17114    Cancels_Cancel_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Cancels_Cancel_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."Cancels_Cancel_ID_seq";
       public          postgres    false    232    5            �           0    0    Cancels_Cancel_ID_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."Cancels_Cancel_ID_seq" OWNED BY public."Cancels"."Cancel_ID";
          public          postgres    false    231            �            1259    16844 	   Customers    TABLE     ,  CREATE TABLE public."Customers" (
    "Customer_ID" integer NOT NULL,
    "First_Name" character varying(100) NOT NULL,
    "Last_Name" character varying(100) NOT NULL,
    "Email" character varying(255) NOT NULL,
    "Phone_Number" character varying(20) NOT NULL,
    "Loyalty_Program_ID" bigint
);
    DROP TABLE public."Customers";
       public         heap    postgres    false    5            �            1259    16843    Customers_Customer_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Customers_Customer_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Customers_Customer_ID_seq";
       public          postgres    false    5    224            �           0    0    Customers_Customer_ID_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Customers_Customer_ID_seq" OWNED BY public."Customers"."Customer_ID";
          public          postgres    false    223            �            1259    16825 	   Feedbacks    TABLE     �   CREATE TABLE public."Feedbacks" (
    "Feedback_ID" integer NOT NULL,
    "Booking_ID" bigint NOT NULL,
    "Feedback_Text" text NOT NULL,
    "Rating" smallint NOT NULL,
    "Feedback_Date" date NOT NULL,
    "Service_Usage_ID" bigint NOT NULL
);
    DROP TABLE public."Feedbacks";
       public         heap    postgres    false    5            �            1259    16824    Feedbacks_Feedback_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Feedbacks_Feedback_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."Feedbacks_Feedback_ID_seq";
       public          postgres    false    222    5            �           0    0    Feedbacks_Feedback_ID_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Feedbacks_Feedback_ID_seq" OWNED BY public."Feedbacks"."Feedback_ID";
          public          postgres    false    221            �            1259    16749    hotels    TABLE     �   CREATE TABLE public.hotels (
    "Hotel_ID" integer NOT NULL,
    "Location" character varying(255) NOT NULL,
    "Rating" smallint NOT NULL,
    "Number_of_rooms" integer NOT NULL
);
    DROP TABLE public.hotels;
       public         heap    postgres    false    5            �            1259    16748    Hotels_Hotel_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Hotels_Hotel_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Hotels_Hotel_ID_seq";
       public          postgres    false    5    210            �           0    0    Hotels_Hotel_ID_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Hotels_Hotel_ID_seq" OWNED BY public.hotels."Hotel_ID";
          public          postgres    false    209            �            1259    16853    Loyalty_Programs    TABLE       CREATE TABLE public."Loyalty_Programs" (
    "Loyalty_Program_ID" integer NOT NULL,
    "Program_Name" character varying(255) NOT NULL,
    "Description" text NOT NULL,
    "Points_Accrued" integer NOT NULL,
    "Tier" character varying(50) NOT NULL,
    "Benefits" text NOT NULL
);
 &   DROP TABLE public."Loyalty_Programs";
       public         heap    postgres    false    5            �            1259    16852 '   Loyalty_Programs_Loyalty_Program_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Loyalty_Programs_Loyalty_Program_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public."Loyalty_Programs_Loyalty_Program_ID_seq";
       public          postgres    false    226    5            �           0    0 '   Loyalty_Programs_Loyalty_Program_ID_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE public."Loyalty_Programs_Loyalty_Program_ID_seq" OWNED BY public."Loyalty_Programs"."Loyalty_Program_ID";
          public          postgres    false    225            �            1259    16782    Payments    TABLE     ^  CREATE TABLE public."Payments" (
    "Payment_ID" integer NOT NULL,
    "Booking_ID" bigint NOT NULL,
    "Payment_Date" date NOT NULL,
    "Amount" numeric(10,2) NOT NULL,
    "Currency" character varying(3) NOT NULL,
    "Payment_Status" character varying(50) NOT NULL,
    "Service_Usage_ID" integer,
    "Payment_Method" character varying(50)
);
    DROP TABLE public."Payments";
       public         heap    postgres    false    5            �            1259    16781    Payments_Payment_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Payments_Payment_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Payments_Payment_ID_seq";
       public          postgres    false    216    5            �           0    0    Payments_Payment_ID_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."Payments_Payment_ID_seq" OWNED BY public."Payments"."Payment_ID";
          public          postgres    false    215            �            1259    17035 	   Room_Type    TABLE     �   CREATE TABLE public."Room_Type" (
    "Type_ID" integer NOT NULL,
    "Name" character varying(255),
    "Description" text,
    "Number_of_Guests" integer
);
    DROP TABLE public."Room_Type";
       public         heap    postgres    false    5            �            1259    17034    Room_Type_Type_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Room_Type_Type_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."Room_Type_Type_ID_seq";
       public          postgres    false    230    5            �           0    0    Room_Type_Type_ID_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."Room_Type_Type_ID_seq" OWNED BY public."Room_Type"."Type_ID";
          public          postgres    false    229            �            1259    16758    Rooms    TABLE     >  CREATE TABLE public."Rooms" (
    "Room_ID" integer NOT NULL,
    "Hotel_ID" bigint NOT NULL,
    "Room_Number" integer NOT NULL,
    "Rate_Per_Night" numeric(10,2) NOT NULL,
    "Floor" integer NOT NULL,
    "Occupancy_Status" boolean NOT NULL,
    "Last_Maintenance_Date" date NOT NULL,
    "Room_Type_ID" bigint
);
    DROP TABLE public."Rooms";
       public         heap    postgres    false    5            �            1259    16757    Rooms_Room_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Rooms_Room_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Rooms_Room_ID_seq";
       public          postgres    false    5    212            �           0    0    Rooms_Room_ID_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Rooms_Room_ID_seq" OWNED BY public."Rooms"."Room_ID";
          public          postgres    false    211            �            1259    16794    Services    TABLE     �   CREATE TABLE public."Services" (
    "Service_ID" integer NOT NULL,
    "Service_Name" character varying(255) NOT NULL,
    "Hotel_ID" bigint NOT NULL,
    "Description" text NOT NULL,
    "Price" numeric(10,2) NOT NULL
);
    DROP TABLE public."Services";
       public         heap    postgres    false    5            �            1259    16793    Services_Service_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Services_Service_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Services_Service_ID_seq";
       public          postgres    false    5    218            �           0    0    Services_Service_ID_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."Services_Service_ID_seq" OWNED BY public."Services"."Service_ID";
          public          postgres    false    217            �            1259    16808    Services_Usage    TABLE     �   CREATE TABLE public."Services_Usage" (
    "Service_Usage_ID" integer NOT NULL,
    "Booking_ID" bigint NOT NULL,
    "Service_ID" bigint NOT NULL,
    "Usage_Date" date NOT NULL
);
 $   DROP TABLE public."Services_Usage";
       public         heap    postgres    false    5            �            1259    16807 #   Services_Usage_Service_Usage_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Services_Usage_Service_Usage_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public."Services_Usage_Service_Usage_ID_seq";
       public          postgres    false    220    5            �           0    0 #   Services_Usage_Service_Usage_ID_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public."Services_Usage_Service_Usage_ID_seq" OWNED BY public."Services_Usage"."Service_Usage_ID";
          public          postgres    false    219            �            1259    16862    Staff    TABLE     j  CREATE TABLE public."Staff" (
    "Staff_ID" integer NOT NULL,
    "First_Name" character varying(100) NOT NULL,
    "Last_Name" character varying(100) NOT NULL,
    "Position" character varying(100) NOT NULL,
    "Department" character varying(100) NOT NULL,
    "Hotel_ID" bigint NOT NULL,
    "Salary" numeric(10,2) NOT NULL,
    "Hire_date" date NOT NULL
);
    DROP TABLE public."Staff";
       public         heap    postgres    false    5            �            1259    16861    Staff_Staff_ID_seq    SEQUENCE     �   CREATE SEQUENCE public."Staff_Staff_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Staff_Staff_ID_seq";
       public          postgres    false    228    5            �           0    0    Staff_Staff_ID_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Staff_Staff_ID_seq" OWNED BY public."Staff"."Staff_ID";
          public          postgres    false    227            �           2604    16883    Bookings Booking_ID    DEFAULT     �   ALTER TABLE ONLY public."Bookings" ALTER COLUMN "Booking_ID" SET DEFAULT nextval('public."Bookings_Booking_ID_seq"'::regclass);
 F   ALTER TABLE public."Bookings" ALTER COLUMN "Booking_ID" DROP DEFAULT;
       public          postgres    false    213    214    214            �           2604    17118    Cancels Cancel_ID    DEFAULT     |   ALTER TABLE ONLY public."Cancels" ALTER COLUMN "Cancel_ID" SET DEFAULT nextval('public."Cancels_Cancel_ID_seq"'::regclass);
 D   ALTER TABLE public."Cancels" ALTER COLUMN "Cancel_ID" DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    16884    Customers Customer_ID    DEFAULT     �   ALTER TABLE ONLY public."Customers" ALTER COLUMN "Customer_ID" SET DEFAULT nextval('public."Customers_Customer_ID_seq"'::regclass);
 H   ALTER TABLE public."Customers" ALTER COLUMN "Customer_ID" DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    16885    Feedbacks Feedback_ID    DEFAULT     �   ALTER TABLE ONLY public."Feedbacks" ALTER COLUMN "Feedback_ID" SET DEFAULT nextval('public."Feedbacks_Feedback_ID_seq"'::regclass);
 H   ALTER TABLE public."Feedbacks" ALTER COLUMN "Feedback_ID" DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    16886 #   Loyalty_Programs Loyalty_Program_ID    DEFAULT     �   ALTER TABLE ONLY public."Loyalty_Programs" ALTER COLUMN "Loyalty_Program_ID" SET DEFAULT nextval('public."Loyalty_Programs_Loyalty_Program_ID_seq"'::regclass);
 V   ALTER TABLE public."Loyalty_Programs" ALTER COLUMN "Loyalty_Program_ID" DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    16887    Payments Payment_ID    DEFAULT     �   ALTER TABLE ONLY public."Payments" ALTER COLUMN "Payment_ID" SET DEFAULT nextval('public."Payments_Payment_ID_seq"'::regclass);
 F   ALTER TABLE public."Payments" ALTER COLUMN "Payment_ID" DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    17038    Room_Type Type_ID    DEFAULT     |   ALTER TABLE ONLY public."Room_Type" ALTER COLUMN "Type_ID" SET DEFAULT nextval('public."Room_Type_Type_ID_seq"'::regclass);
 D   ALTER TABLE public."Room_Type" ALTER COLUMN "Type_ID" DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    16888    Rooms Room_ID    DEFAULT     t   ALTER TABLE ONLY public."Rooms" ALTER COLUMN "Room_ID" SET DEFAULT nextval('public."Rooms_Room_ID_seq"'::regclass);
 @   ALTER TABLE public."Rooms" ALTER COLUMN "Room_ID" DROP DEFAULT;
       public          postgres    false    212    211    212            �           2604    16889    Services Service_ID    DEFAULT     �   ALTER TABLE ONLY public."Services" ALTER COLUMN "Service_ID" SET DEFAULT nextval('public."Services_Service_ID_seq"'::regclass);
 F   ALTER TABLE public."Services" ALTER COLUMN "Service_ID" DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16890    Services_Usage Service_Usage_ID    DEFAULT     �   ALTER TABLE ONLY public."Services_Usage" ALTER COLUMN "Service_Usage_ID" SET DEFAULT nextval('public."Services_Usage_Service_Usage_ID_seq"'::regclass);
 R   ALTER TABLE public."Services_Usage" ALTER COLUMN "Service_Usage_ID" DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    16891    Staff Staff_ID    DEFAULT     v   ALTER TABLE ONLY public."Staff" ALTER COLUMN "Staff_ID" SET DEFAULT nextval('public."Staff_Staff_ID_seq"'::regclass);
 A   ALTER TABLE public."Staff" ALTER COLUMN "Staff_ID" DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    16892    hotels Hotel_ID    DEFAULT     v   ALTER TABLE ONLY public.hotels ALTER COLUMN "Hotel_ID" SET DEFAULT nextval('public."Hotels_Hotel_ID_seq"'::regclass);
 @   ALTER TABLE public.hotels ALTER COLUMN "Hotel_ID" DROP DEFAULT;
       public          postgres    false    209    210    210            �          0    16770    Bookings 
   TABLE DATA           �   COPY public."Bookings" ("Booking_ID", "Customer_ID", "Room_ID", "Booking_Date", "CheckIn_Date", "Check_Out_Date", "Booking_Method") FROM stdin;
    public          postgres    false    214   �       �          0    17115    Cancels 
   TABLE DATA           o   COPY public."Cancels" ("Cancel_ID", "Booking_ID", "Cancel_Date", "Cancel_Reason", "Refund_Amount") FROM stdin;
    public          postgres    false    232   t�       �          0    16844 	   Customers 
   TABLE DATA           ~   COPY public."Customers" ("Customer_ID", "First_Name", "Last_Name", "Email", "Phone_Number", "Loyalty_Program_ID") FROM stdin;
    public          postgres    false    224   ��       �          0    16825 	   Feedbacks 
   TABLE DATA           �   COPY public."Feedbacks" ("Feedback_ID", "Booking_ID", "Feedback_Text", "Rating", "Feedback_Date", "Service_Usage_ID") FROM stdin;
    public          postgres    false    222   ��       �          0    16853    Loyalty_Programs 
   TABLE DATA           �   COPY public."Loyalty_Programs" ("Loyalty_Program_ID", "Program_Name", "Description", "Points_Accrued", "Tier", "Benefits") FROM stdin;
    public          postgres    false    226   �       �          0    16782    Payments 
   TABLE DATA           �   COPY public."Payments" ("Payment_ID", "Booking_ID", "Payment_Date", "Amount", "Currency", "Payment_Status", "Service_Usage_ID", "Payment_Method") FROM stdin;
    public          postgres    false    216   u�       �          0    17035 	   Room_Type 
   TABLE DATA           [   COPY public."Room_Type" ("Type_ID", "Name", "Description", "Number_of_Guests") FROM stdin;
    public          postgres    false    230   �       �          0    16758    Rooms 
   TABLE DATA           �   COPY public."Rooms" ("Room_ID", "Hotel_ID", "Room_Number", "Rate_Per_Night", "Floor", "Occupancy_Status", "Last_Maintenance_Date", "Room_Type_ID") FROM stdin;
    public          postgres    false    212   ��       �          0    16794    Services 
   TABLE DATA           f   COPY public."Services" ("Service_ID", "Service_Name", "Hotel_ID", "Description", "Price") FROM stdin;
    public          postgres    false    218   ��       �          0    16808    Services_Usage 
   TABLE DATA           h   COPY public."Services_Usage" ("Service_Usage_ID", "Booking_ID", "Service_ID", "Usage_Date") FROM stdin;
    public          postgres    false    220   V�       �          0    16862    Staff 
   TABLE DATA           �   COPY public."Staff" ("Staff_ID", "First_Name", "Last_Name", "Position", "Department", "Hotel_ID", "Salary", "Hire_date") FROM stdin;
    public          postgres    false    228   ��       �          0    16749    hotels 
   TABLE DATA           U   COPY public.hotels ("Hotel_ID", "Location", "Rating", "Number_of_rooms") FROM stdin;
    public          postgres    false    210   ��       �           0    0    Bookings_Booking_ID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Bookings_Booking_ID_seq"', 1, false);
          public          postgres    false    213            �           0    0    Cancels_Cancel_ID_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."Cancels_Cancel_ID_seq"', 59, true);
          public          postgres    false    231            �           0    0    Customers_Customer_ID_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Customers_Customer_ID_seq"', 1, false);
          public          postgres    false    223            �           0    0    Feedbacks_Feedback_ID_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Feedbacks_Feedback_ID_seq"', 1, false);
          public          postgres    false    221            �           0    0    Hotels_Hotel_ID_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Hotels_Hotel_ID_seq"', 1, false);
          public          postgres    false    209            �           0    0 '   Loyalty_Programs_Loyalty_Program_ID_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."Loyalty_Programs_Loyalty_Program_ID_seq"', 1, false);
          public          postgres    false    225            �           0    0    Payments_Payment_ID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Payments_Payment_ID_seq"', 1, false);
          public          postgres    false    215            �           0    0    Room_Type_Type_ID_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."Room_Type_Type_ID_seq"', 1, false);
          public          postgres    false    229            �           0    0    Rooms_Room_ID_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Rooms_Room_ID_seq"', 1, false);
          public          postgres    false    211            �           0    0    Services_Service_ID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Services_Service_ID_seq"', 1, false);
          public          postgres    false    217            �           0    0 #   Services_Usage_Service_Usage_ID_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public."Services_Usage_Service_Usage_ID_seq"', 1, false);
          public          postgres    false    219            �           0    0    Staff_Staff_ID_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Staff_Staff_ID_seq"', 1, false);
          public          postgres    false    227            �           2606    16775    Bookings Bookings_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."Bookings"
    ADD CONSTRAINT "Bookings_pkey" PRIMARY KEY ("Booking_ID");
 D   ALTER TABLE ONLY public."Bookings" DROP CONSTRAINT "Bookings_pkey";
       public            postgres    false    214            �           2606    17122    Cancels Cancels_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Cancels"
    ADD CONSTRAINT "Cancels_pkey" PRIMARY KEY ("Cancel_ID");
 B   ALTER TABLE ONLY public."Cancels" DROP CONSTRAINT "Cancels_pkey";
       public            postgres    false    232            �           2606    16851    Customers Customers_Email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public."Customers"
    ADD CONSTRAINT "Customers_Email_key" UNIQUE ("Email");
 K   ALTER TABLE ONLY public."Customers" DROP CONSTRAINT "Customers_Email_key";
       public            postgres    false    224            �           2606    16849    Customers Customers_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public."Customers"
    ADD CONSTRAINT "Customers_pkey" PRIMARY KEY ("Customer_ID");
 F   ALTER TABLE ONLY public."Customers" DROP CONSTRAINT "Customers_pkey";
       public            postgres    false    224            �           2606    16832    Feedbacks Feedbacks_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public."Feedbacks"
    ADD CONSTRAINT "Feedbacks_pkey" PRIMARY KEY ("Feedback_ID");
 F   ALTER TABLE ONLY public."Feedbacks" DROP CONSTRAINT "Feedbacks_pkey";
       public            postgres    false    222            �           2606    16756    hotels Hotels_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT "Hotels_pkey" PRIMARY KEY ("Hotel_ID");
 >   ALTER TABLE ONLY public.hotels DROP CONSTRAINT "Hotels_pkey";
       public            postgres    false    210            �           2606    16860 &   Loyalty_Programs Loyalty_Programs_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public."Loyalty_Programs"
    ADD CONSTRAINT "Loyalty_Programs_pkey" PRIMARY KEY ("Loyalty_Program_ID");
 T   ALTER TABLE ONLY public."Loyalty_Programs" DROP CONSTRAINT "Loyalty_Programs_pkey";
       public            postgres    false    226            �           2606    16787    Payments Payments_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "Payments_pkey" PRIMARY KEY ("Payment_ID");
 D   ALTER TABLE ONLY public."Payments" DROP CONSTRAINT "Payments_pkey";
       public            postgres    false    216            �           2606    17042    Room_Type Room_Type_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Room_Type"
    ADD CONSTRAINT "Room_Type_pkey" PRIMARY KEY ("Type_ID");
 F   ALTER TABLE ONLY public."Room_Type" DROP CONSTRAINT "Room_Type_pkey";
       public            postgres    false    230            �           2606    16763    Rooms Rooms_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Rooms"
    ADD CONSTRAINT "Rooms_pkey" PRIMARY KEY ("Room_ID");
 >   ALTER TABLE ONLY public."Rooms" DROP CONSTRAINT "Rooms_pkey";
       public            postgres    false    212            �           2606    16813 "   Services_Usage Services_Usage_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public."Services_Usage"
    ADD CONSTRAINT "Services_Usage_pkey" PRIMARY KEY ("Service_Usage_ID");
 P   ALTER TABLE ONLY public."Services_Usage" DROP CONSTRAINT "Services_Usage_pkey";
       public            postgres    false    220            �           2606    16801    Services Services_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."Services"
    ADD CONSTRAINT "Services_pkey" PRIMARY KEY ("Service_ID");
 D   ALTER TABLE ONLY public."Services" DROP CONSTRAINT "Services_pkey";
       public            postgres    false    218            �           2606    16867    Staff Staff_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_pkey" PRIMARY KEY ("Staff_ID");
 >   ALTER TABLE ONLY public."Staff" DROP CONSTRAINT "Staff_pkey";
       public            postgres    false    228            �           2620    17129    Cancels refund_trigger    TRIGGER     w   CREATE TRIGGER refund_trigger BEFORE INSERT ON public."Cancels" FOR EACH ROW EXECUTE FUNCTION public.process_refund();
 1   DROP TRIGGER refund_trigger ON public."Cancels";
       public          postgres    false    233    232            �           2606    17123    Cancels Cancels_Booking_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Cancels"
    ADD CONSTRAINT "Cancels_Booking_ID_fkey" FOREIGN KEY ("Booking_ID") REFERENCES public."Bookings"("Booking_ID") ON DELETE CASCADE;
 M   ALTER TABLE ONLY public."Cancels" DROP CONSTRAINT "Cancels_Booking_ID_fkey";
       public          postgres    false    232    3282    214            �           2606    17049    Customers Cutomers_fk5    FK CONSTRAINT     �   ALTER TABLE ONLY public."Customers"
    ADD CONSTRAINT "Cutomers_fk5" FOREIGN KEY ("Loyalty_Program_ID") REFERENCES public."Loyalty_Programs"("Loyalty_Program_ID") ON DELETE SET NULL;
 D   ALTER TABLE ONLY public."Customers" DROP CONSTRAINT "Cutomers_fk5";
       public          postgres    false    3296    226    224            �           2606    16838 )   Feedbacks Feedbacks_Service_Usage_ID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Feedbacks"
    ADD CONSTRAINT "Feedbacks_Service_Usage_ID_fkey" FOREIGN KEY ("Service_Usage_ID") REFERENCES public."Services_Usage"("Service_Usage_ID");
 W   ALTER TABLE ONLY public."Feedbacks" DROP CONSTRAINT "Feedbacks_Service_Usage_ID_fkey";
       public          postgres    false    222    3288    220            �           2606    17044    Rooms Rooms_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY public."Rooms"
    ADD CONSTRAINT "Rooms_fk3" FOREIGN KEY ("Room_Type_ID") REFERENCES public."Room_Type"("Type_ID") ON DELETE CASCADE;
 =   ALTER TABLE ONLY public."Rooms" DROP CONSTRAINT "Rooms_fk3";
       public          postgres    false    3300    230    212            �           2606    17074    Payments fk_booking    FK CONSTRAINT     �   ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT fk_booking FOREIGN KEY ("Booking_ID") REFERENCES public."Bookings"("Booking_ID");
 ?   ALTER TABLE ONLY public."Payments" DROP CONSTRAINT fk_booking;
       public          postgres    false    216    214    3282            �           2606    17094    Feedbacks fk_booking_feedback    FK CONSTRAINT     �   ALTER TABLE ONLY public."Feedbacks"
    ADD CONSTRAINT fk_booking_feedback FOREIGN KEY ("Booking_ID") REFERENCES public."Bookings"("Booking_ID");
 I   ALTER TABLE ONLY public."Feedbacks" DROP CONSTRAINT fk_booking_feedback;
       public          postgres    false    222    3282    214            �           2606    17084 '   Services_Usage fk_booking_service_usage    FK CONSTRAINT     �   ALTER TABLE ONLY public."Services_Usage"
    ADD CONSTRAINT fk_booking_service_usage FOREIGN KEY ("Booking_ID") REFERENCES public."Bookings"("Booking_ID");
 S   ALTER TABLE ONLY public."Services_Usage" DROP CONSTRAINT fk_booking_service_usage;
       public          postgres    false    3282    220    214            �           2606    17069    Bookings fk_customer    FK CONSTRAINT     �   ALTER TABLE ONLY public."Bookings"
    ADD CONSTRAINT fk_customer FOREIGN KEY ("Customer_ID") REFERENCES public."Customers"("Customer_ID");
 @   ALTER TABLE ONLY public."Bookings" DROP CONSTRAINT fk_customer;
       public          postgres    false    224    214    3294            �           2606    17059    Rooms fk_hotel    FK CONSTRAINT     {   ALTER TABLE ONLY public."Rooms"
    ADD CONSTRAINT fk_hotel FOREIGN KEY ("Hotel_ID") REFERENCES public.hotels("Hotel_ID");
 :   ALTER TABLE ONLY public."Rooms" DROP CONSTRAINT fk_hotel;
       public          postgres    false    3278    212    210            �           2606    17079    Services fk_hotel_service    FK CONSTRAINT     �   ALTER TABLE ONLY public."Services"
    ADD CONSTRAINT fk_hotel_service FOREIGN KEY ("Hotel_ID") REFERENCES public.hotels("Hotel_ID");
 E   ALTER TABLE ONLY public."Services" DROP CONSTRAINT fk_hotel_service;
       public          postgres    false    210    218    3278            �           2606    17104    Staff fk_hotel_staff    FK CONSTRAINT     �   ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT fk_hotel_staff FOREIGN KEY ("Hotel_ID") REFERENCES public.hotels("Hotel_ID");
 @   ALTER TABLE ONLY public."Staff" DROP CONSTRAINT fk_hotel_staff;
       public          postgres    false    210    3278    228            �           2606    17064    Bookings fk_room    FK CONSTRAINT     |   ALTER TABLE ONLY public."Bookings"
    ADD CONSTRAINT fk_room FOREIGN KEY ("Room_ID") REFERENCES public."Rooms"("Room_ID");
 <   ALTER TABLE ONLY public."Bookings" DROP CONSTRAINT fk_room;
       public          postgres    false    3280    214    212            �           2606    17089    Services_Usage fk_service_usage    FK CONSTRAINT     �   ALTER TABLE ONLY public."Services_Usage"
    ADD CONSTRAINT fk_service_usage FOREIGN KEY ("Service_ID") REFERENCES public."Services"("Service_ID");
 K   ALTER TABLE ONLY public."Services_Usage" DROP CONSTRAINT fk_service_usage;
       public          postgres    false    220    3286    218            �           2606    17138    Payments fk_service_usage    FK CONSTRAINT     �   ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT fk_service_usage FOREIGN KEY ("Service_Usage_ID") REFERENCES public."Services_Usage"("Service_Usage_ID");
 E   ALTER TABLE ONLY public."Payments" DROP CONSTRAINT fk_service_usage;
       public          postgres    false    216    220    3288            �   U  x��V�n�0�yO��B�$[�Vt�ҹK�� �����x�G�C�oH��Y��ǁ�5�kK�-�V2he9���r{{]~~�^?.;�g�rq	�Ž%G��1�Y82�e��qh���e��d����9������v��C^����!�c��������6<&4��d���[��g��`j��8O޿����E�A/D��c+�WZ�Yb2��Q�c��+�#�t���(�k)Z[��������%�~Fg���qj���8J��b��]��K+�x����{������	��w���be�U���b�w8L�im9B[�m��&�q��LV��s���z�����+bުb��.�<�a���7�~���Iy���㽕�<�,|È���K��7��)�����!�Bs�Z "�Ī%��6t�H��s`̸�a�m/˴�'׫�zf��~{[^�/�62�;8I.��8
�$^� ��Rb�j��]�?��d���3A��UZ�x~|w%U���[��kBsl��I\�m�|Kh�
J�V�q�.~���HO��,�po�w�%A�tҞc��xF�������.��ۘP�➙�q���\.02hҞ�'w�]`k!ch/��<K2�.���u���.�
�. ��7X�B���%.�Y\e���8>�n��(s)T��.0�W2`�/�%��o���dp���B	���L���n��~�E��y*2����"��0{�;
r"����D8��}��2V�y���r�T�+�B���
���;��zŤ}%�B7[��o�8i��p���`��b�^ɀ5MW��l�,���.�].���h�      �   )  x���MN�0FדS��fƞ��	�`TSQ��rB츱���Y�Ϟ�^#��$Q���n8Y�>�O�#3�	g��/}?�q01.i�=:��5����y�Y]�j�g�;U����l�:ڮ�Z�I�K����]�����LxB����ƹ�du�Y�Kr�jh"&7���@�pnn�l�0�{%ʤ��w=
-"��\�0�N�Z���&d4�b����l��M� I
�}n�� ->۬�$(pP��u�{�@Q'av镟J�(�([s߿�Ñ�U�s��P����      �   �  x���Os�6�ϫ���HP�n��ij��3�fr�$Ԥ���|����ś��G�	X��3��F>D/[f��������:��[��b2��c�F�|r��e]��l�����$Y�
�ڧU�؈#��@�.�J�\Ǖ\����*�̊��;��m]��|pǪ��l+�{��}�.��Tn�М*ʉ����c��_w������Y�q~������+n��]PQΐ�B�q_r�2֮�.��)�9r��L.T�����<l�+���2��s+�����T4'���1;%��/]#]۲"S&Pdl�̢&N�]�W��3u
I���
�~�ʝ�h���-Zf7�l(��=���~�����E^0é\���d���AN��L�j�`��c$GPdS�9Gs7���xh�e���	�l�,,���]AU���*U4眏Q��/�I�k������-����g�Y�g��KМv��T�����;Lb�+�Y�K8�ʵcٞ��S+��S�B>GW���u��I2���eV���<���@o�3T$����a�A}�+����iR����qĘ���#f<������Q-N�C���w(��/�Hg�l1��/p����/���ώ�b��e	b"�O��)6CKa�<����X��'�/��)6���i�r�gXKI0uE�� �9��nbܧ�=�"���"9&:�
�̾ܡ�+"z��=t����#�vò��Ĵ?�(@W�SY����
	b�;�^�[�)R��E�p�',"<��(:�����8���p-u����!=�.���R�o8͟��R�:�D���C��XN/)2��z|0`�C�/��h��K-=��_��]�^ͲM��+��[6L�&��,�E��T
�P5�:��'�n�%�����×�cl�g�"��S|@u����i8:ۄ8��~R��]oB�ׯd���Bj�뻦����m�&��m@��1���^2�ms~�b���$_�h4���GB      �   k  x�u�ю�6E�ɯ��K�d�1�IѴX4-�}����.E�$�^��;Cɖ�&� ��3s��!3��T޹N�/��7��U��u}|`%˷y��f��b�Y��hA�^��
Q�ڞ߈��G��z�G5���w,�I�V���(B;�h 㬈���։�ms�|������I���rS�I�8V\BG肸������{;);���x�k��/`��t�C3S{wi��K�d%�X�u������=9ߩ�_`���y��X�uQ�=����2V�۱'���ҏkg_�j���m��z�0�@ճ߳={t����c�L���؊�st`��0�C
���v�M��=?�{rΌ�(�߆:�.I�϶���F`����L#� ��~��P�*[�,EI�ȶ�$���Q�i��ZC����%U�³���ث��&�ٹ�:���}��%�����	���)��W���`��iw�D&yV0�~���;I���utV*�kFm<+~�����{+�D�n�i<ع�=M<+9�^�~w��Qע�֢�����dթ����i�Y�q��{H>=9ͬs�ZS�-�!���ٞ��Q��M�A��U�8�������{NMأ��~�%����mS{�o�د*jȫ�����gG���-�ٓ�.`^I�� F����90��r�q���:�Oj�1���|��wU��^9ω_����a�0A��	W�]
�!�0��91�q��u4C�FW��C̅�Â��/(\Z���c������K�����ED.�6B��3)�[��*�	K�9�ҁ��]����
K���	Po�4�[�S��Ο��_��3�Q�|�s��ۆ��'T�6�Q�t���Ƭ�.�~���ħ��`�Zvy/��՜0���ğ���mt�v!.I�id�eb��W5] ¸���⚦5�ni���}K&�6L���c�]O��[�H�h�z���'�L��thRׯ�-����%�J\&
�1R�A��"���y�w-R!Ș,�L<���d�	��k��JEޒ��Fw��!������'��^���q��4�"�+�6�Wd����HĊ�s9RiZ�[�!��{S��_��>�"�i��U�m\�B��C�Q�|sVlyA|�����J[�ף�����(&,2^��a�m6^�G��ó^h}�=�,r^��7=C���R�H���%A��ۊ@uK��&=]:�q��8����-\� B=�[�h\r%9��4ڝɗK�n3V�� P�_{��WH@w�W�2fa,������n�7�2&=9��%N�)v� 6-cU���=H\�t��MF�3�+V�yA`_�/�s�鵻z+�$�L8Z��b8!ќ�.�8�r��~����_"      �   F  x���?O�0�g�S�VIڊ�[��\�S�'��~{�R�":��:�|����/dzdxƝ�&�;HUб_���z���=���Nb��EY�JT�4�O��;`�-����	Qm[��ţ7�I��m����R�Q܀j��2�B�-�ՠY��Z�"%���7��rr&�FErɞP���r}�?�I�z�y�)fe������CC���f��x��)ʹ�'e�;3�P�Oև�2);xI)���?��P�+@{��9|�{���ܓ� ��i9�V�;}7���lL�vHr���_ҟ�Cb�C�;�	���.ߦR�O�
k      �   �  x�u��n1Dϥ���`/\�e�F�|"�1�8���G���Ѵ]�n����}�=)R7!���w����t~=��8��O��Ǘ�.".b?��T�UEAY*tO��NEYU�~sM�FLN�!�"и
Agaw?>��������Bqm��5%�Rh��Qf���[��?�O�
&�����*����Pv��
N�0V0m�M�� �]8J��ihHe��ʌT6�pt�&[ߋ5WM�=A���l��&P� Y\��$�@��)4.�`��r+j�u-�v16��'c�mz��G>��n�b�t� �Cj�$���qmC�f%��w�ʜc����״�J�#,�W*-͒ ���n�4m���#,��_�U��g�f�f@�*P(~t~�	�F��A�^����:��ί��.��*�Ƅ���������_;���k��ր��),� �L@.[VgV&�4Xz��.��U�r�[�n�0�Ѿ�Co��0�Z�^���⃽@Ҟ{��[$��>���p�%��1�m�(���8_���.�LI�J=�xE�.�p����ū��.��M��[���:���!�߽}�ܓd��%Bb��$�U,RƜ����2�1��?I��Xm�j������ǜ�?']'"�����w/�q������
�      �   �   x�M�A�@EםS� f��xٺ)Pq�d:���M�����_A���x�����_-c�F�KDBݙ!�&���"���&�j���V��5����w���C����t����?Zy�Hv�a�}��tؐm�L��X�����n�9���H�      �   �  x�e�]�d!��q/�����s�`����Τn�J��|�v������7�>���mX\���#�F#���7;Pc2�#��?-�#��h[�_��7P�S��%����ßb>}�صk���Q��b�p� � �;�M�PA ��mL����0!6A f8LMB���/��I�
��Ylb��z����/�v"v8���&����h�@T�b8pq��,� '��b�	Qb�������p5Is� �-���K���N�����?>��{E�5Y|�����OaE��W8�$+�\4V%D�IV���#��R�Պ����IVT�h^GY�IV�y�R5X
�vR�qM��t�#>�5���T�2(����J�U��I�d��5��ZDk,��j��Y�@ϝ�5ɚ���tM�f����}֧�V�?K5�5�Z�ܗ�u\��U�k�e�Ū��������]��]�k�z�|����(      �   �  x��W�n�6]3_�H`�r�ԓf��8�`�n��S�JR����F�_�s���L��,�qt�{�d_���Vڃ�$[���l�h��e��Q��~VI��157�W�wWl��Z,.
� �H-��~�� ��R�N��q�׼Ή�ĝe.�ؽ����o��{-Y�^��]X�&�j,���"��b�p�dOb�k{������8q�� �����fųW,Z�f����W�t����@o���K�w8�P���JÍ�Ě���jY�Bt^>�Џ�PLE)��T�t����,����me5Zɇ�@1Dc�)�to.��[�1}����)%�wN9/���Wc���:(�d̅�	�rX�`ܱgct�������_;�s�q�!\^.�O�S!D�\�7�y�
{�����Wz��U���BE�zI��.��g@�*$�B!F�ųk����A����91��uܵ��]4�`��S�^ ���`D%lL�)���j�5�v1V�� ���=��ݰ���y+���E@c,�^rI�(���S�O�e��r��S� n�`e�Ǝ��ƫ��:��Q�ug�X�\�_T����2�ҵ�}H�;N�q��d��(`fn,�!b�*�@�>�j�r�v�����&�"�|�Q"/�3=n�ڑ!���%OK�P�̹D!�f"�-��v�%^c?%� e�TK�.�g&��֌;H����xy�6Ȋ�7O����ȧNJbF�Vr:�1Q�X��Q��K+�N�H�H28�w����%{��@��������ԟ���糶D-�R']-
�4~�Ս����Mh�)܍۠����8m"Ɗ}3;��4� �>�(V����$?(ɹNf�%d*J�ԓ��4��Q�Ȃ��&FfV�l sa���D��*�j�9�"ܘ���ީ�/�Ȝ�U�]W���,��WR��( :=�}ҧ�7V��nS3�a�F7�u�1{��z�;:PQ.�Pg>Y$�,����0����=	pd'�&�K�vtr�&�*P5����T� -{���}m�rgU�j�2Q�,���1v��5 a��$��S�I������hjn$����m}&�n���2�8L�d�Cri��:�S:����SO����d�l�z���tPǃ�[׵J��Xч�䦽Z��ZU����);jxA�C���j!?}� I��I&�Z��m̀`�w���VN:[g�H�%��6�Y�!����JyV1��і!M%�s%��ٯPQ�U#�L`g4�Y�O��@y��8�7��E䛹�<J/��6S���_?9J�G��ju{F�-͈�P��i7L��o��ݤSd5��UE4�ە�ȓ���NͱG8�b��(���HKPi�Ocn���?����rɶ{����?h��&���qc�&)��|$�轘t�D�g����jz?e�\as-��ŪPE�jҺ��TF��1�!� 
��Y�K���*0THm���?��4�|߁9�y�f۱w���h\�GH�It�X� Tm��-�4�޲i%fc[�`�j��1��!�����`6A׶�j"ź�?	�y�f0��u��f��,	��!�<�f�;獩*�f�T���"�5�,Z��q�����Jc�:��z��7Q�>O��'�ĉ���+��Ƞ;v�y*]@������_���C      �   K  x�M�ɍ�0C�T/X����鿎�^ ������`ibO㇅9�褈)C����~�#��S4�n4SF�ҋ�eH�1e���J��ػ��͂��D���f�Jˋ��Ryo4���O���2�Eiy�*�PJ�[�I��T�牿`��9���Ϲx��{�,���������?������ �7z���z�Abo��M�za�G�c�!�
�L��_zܪ�0�����ȼ�0�̛��̼za���AG��Y���v���j;�B5��Ԝ�����
������&lc(���6�@�?���Q�7�C�����R��      �   �  x��WMw�6</~O�1� H�:�Nl7�Er�����-<Q�H)�}�� Jv/�E������R�"����R��h�7�J���*��k��<
,K�I,a<N�1������X)��E��J���[c��oѵ�K+^�;`|<�Ŕ�tLh_K�W������h&KQ+���si���_����LŮ�Gak��(e}�"��'�.�c��SZ���l��k�E��R�A�Y�Bs�)��;a���]Ge��nJi�ރ�y|+���\l���+��t-�Ѕ�滭+�2����~,f����� �;l-k��1v�����; iD�?m�+��i�!�ѣЈ����j2��0�U�n]�r�/!�X>��}I`1"���� Si�9�y*����=����4%,��Dsv��N̦��mE�#a��7ZK�[�� 3Yȭ#
c@i �4f���#�ܖ�b�7+�-e4u�xd4#���U�EÝѯ�����sB�@f8c�y�W�J{P��x�������J��I���洁u��FXS�B�����BI�H������>��Zb!����i�	���>�Mk~�`��:y����?��$����rg!X>͓*��5�d�&�YkxT�e���>D_�����w�ĿG��1�Y�e="`O�������NJ9�*�x;�f��a+���sA�>~�M1x@��\U��H����U4t���~��!CnE���۶n��S��ƙZ+ǦE�]W:J�Y	]�ޓ�6�	ay#��{�{)��Q��\�<� ��&�ZgR.���Н�^c�	'<��h���*gZ
4�˪iZN8�_�^١iXg��Ayǉ���Y���R��t��7��Ù˜9�$8u���ю[�X�{��"��`�6G��]���yҐ�dLx�J�	ezO_��\6x� ���A��.O�(��|�p����q��J���5����<�e$9o���%�7�Y譎�I30��F�|���;0���0r�&m��7?R�0q:�Ե��$�}�C���:���;�8�w��뤬u3�T�:6�FRޅ����mn>���l��Vb�+�#��"b.i�i����Y ��jR�o��h�n�Y���Q�5`'�ʱ3js޼0u�#��!�0��Ժ,��A��`�:����n��*7�CѾ���<�A��.�u9�j�Q.dY���_��T�y�G�Β>��۾=Mx�A��Q#u������ �2�q      �     x�5�[n� D�oXL�=��^��uԗ��Q�O#׊�ךI�q�� ��F�5M0��5/�U�TOn�Ͷ\�!<c�/�˶z�>.x֌U��:�JAچ�� ���"���ű_%�#@bCT	Il	�Ħ�>,���K�>�X2z�Ē�#$�<�Ē>�a��	�`�SJb��Jb�m��<a��EXt,¢�օE�"���]a��jaѱ�N/¢Ӌ��X�ŧcqt����i��j���=����i��w���O�g,~�����ra���ߟ9��h�     